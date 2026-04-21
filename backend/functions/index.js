const functions = require("firebase-functions");
const admin = require("firebase-admin");
const cors = require("cors")({ origin: true });
admin.initializeApp();

const db = admin.firestore();

// Middleware to construct standard responses
const createResponse = (res, status, data, message = null) => {
  return res.status(status).json({
    success: status >= 200 && status < 300,
    data,
    message,
  });
};

// 1. GET /quotes - Returns a feed of quotes
exports.getQuotes = functions.https.onRequest(async (req, res) => {
  return cors(req, res, async () => {
    try {
      const limit = Math.min(parseInt(req.query.limit) || 20, 100);
      const category = req.query.category;

      let query = db.collection("quotes").limit(limit);
      if (category && category !== "All") {
        query = query.where("category", "==", category);
      } else {
        query = query.orderBy("popularity_score", "desc");
      }

      const snapshot = await query.get();
      const quotes = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));

      return createResponse(res, 200, quotes);
    } catch (error) {
      functions.logger.error("Error fetching quotes:", error);
      return createResponse(res, 500, null, "Failed to retrieve quotes");
    }
  });
});

// 2. GET /quotes/category - Utility to list available categories
exports.getCategories = functions.https.onRequest(async (req, res) => {
  return cors(req, res, async () => {
    try {
      const snapshot = await db.collection("quotes").get();
      const categories = [...new Set(snapshot.docs.map(doc => doc.data().category))];
      return createResponse(res, 200, categories);
    } catch (error) {
      functions.logger.error("Error fetching categories:", error);
      return createResponse(res, 500, null, "Internal Server Error");
    }
  });
});

// 3. GET /daily-quote - Returns the curated quote of the day
exports.getDailyQuote = functions.https.onRequest(async (req, res) => {
  return cors(req, res, async () => {
    try {
      const today = new Date().toISOString().split("T")[0];
      const docRef = await db.collection("daily_quotes").doc(today).get();

      if (!docRef.exists) {
        const fallbackSnapshot = await db.collection("quotes")
          .orderBy("popularity_score", "desc")
          .limit(1)
          .get();

        if (fallbackSnapshot.empty) {
          return createResponse(res, 404, null, "No quotes found");
        }
        return createResponse(res, 200, {
          id: fallbackSnapshot.docs[0].id,
          ...fallbackSnapshot.docs[0].data(),
        });
      }

      const quoteId = docRef.data().quote_id;
      const quoteDoc = await db.collection("quotes").doc(quoteId).get();

      if (!quoteDoc.exists) {
        return createResponse(res, 404, null, "Daily quote not found");
      }

      return createResponse(res, 200, { id: quoteDoc.id, ...quoteDoc.data() });
    } catch (error) {
      functions.logger.error("Error fetching daily quote:", error);
      return createResponse(res, 500, null, "Internal Server Error");
    }
  });
});

// 4. POST /favorite - Toggle favorite status
exports.toggleFavorite = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "Login required");
  }

  const userId = context.auth.uid;
  const { quoteId, action } = data;

  if (!quoteId || !action) {
    throw new functions.https.HttpsError("invalid-argument", "Missing parameters");
  }

  try {
    const userRef = db.collection("users").doc(userId);
    const quoteRef = db.collection("quotes").doc(quoteId);

    await db.runTransaction(async (t) => {
      const userDoc = await t.get(userRef);
      const favorites = (userDoc.exists ? userDoc.data().favorite_quotes : []) || [];

      if (action === "add" && !favorites.includes(quoteId)) {
        favorites.push(quoteId);
        t.set(userRef, { favorite_quotes: favorites }, { merge: true });
        t.update(quoteRef, { popularity_score: admin.firestore.FieldValue.increment(5) });
      } else if (action === "remove" && favorites.includes(quoteId)) {
        const newFavorites = favorites.filter(id => id !== quoteId);
        t.update(userRef, { favorite_quotes: newFavorites });
        t.update(quoteRef, { popularity_score: admin.firestore.FieldValue.increment(-5) });
      }
    });

    return { success: true };
  } catch (error) {
    functions.logger.error("Error toggling favorite:", error);
    throw new functions.https.HttpsError("internal", "Update failed");
  }
});

// 5. GET /favorites - Returns user's favorite quotes
exports.getFavorites = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "Login required");
  }

  const userId = context.auth.uid;

  try {
    const userDoc = await db.collection("users").doc(userId).get();
    const favoriteIds = (userDoc.exists ? userDoc.data().favorite_quotes : []) || [];

    if (favoriteIds.length === 0) return [];

    // Chunking to handle Firestore 'in' query limit of 10-30 depending on SDK
    const quotes = [];
    const chunks = [];
    for (let i = 0; i < favoriteIds.length; i += 10) {
      chunks.push(favoriteIds.slice(i, i + 10));
    }

    for (const chunk of chunks) {
      const snapshot = await db.collection("quotes").where(admin.firestore.FieldPath.documentId(), "in", chunk).get();
      snapshot.docs.forEach(doc => quotes.push({ quote_id: doc.id, ...doc.data() }));
    }

    return quotes;
  } catch (error) {
    functions.logger.error("Error fetching favorites:", error);
    throw new functions.https.HttpsError("internal", "Failed to retrieve favorites");
  }
});

// 6. POST /share - Log share analytics
exports.logShare = functions.https.onCall(async (data, context) => {
  const { quoteId } = data;
  if (!quoteId) {
    throw new functions.https.HttpsError("invalid-argument", "Missing quoteId");
  }

  try {
    const quoteRef = db.collection("quotes").doc(quoteId);
    await quoteRef.update({
      shares: admin.firestore.FieldValue.increment(1),
      popularity_score: admin.firestore.FieldValue.increment(2), // Sharing is valuable engagement
    });

    if (context.auth) {
      await db.collection("user_activity").doc(context.auth.uid).set({
        last_share: admin.firestore.FieldValue.serverTimestamp(),
      }, { merge: true });
    }

    return { success: true };
  } catch (error) {
    functions.logger.error("Error logging share:", error);
    throw new functions.https.HttpsError("internal", "Failed to log share");
  }
});

// 7. Compliance: Auto-Delete All User Data Clusters
exports.onUserDeletion = functions.auth.user().onDelete(async (user) => {
  const userId = user.uid;
  functions.logger.log(`Initiating deep purge for user: ${userId}`);

  try {
    const userRef = db.collection("users").doc(userId);
    
    // Recursive purge of known subcollections
    const subcollections = ["journals", "settings", "favorites"];
    for (const sub of subcollections) {
      const snapshot = await userRef.collection(sub).get();
      const batch = db.batch();
      snapshot.docs.forEach(doc => batch.delete(doc.ref));
      await batch.commit();
    }

    await userRef.delete();
    await db.collection("user_activity").doc(userId).delete();

    functions.logger.log(`Deep purge completed for user: ${userId}`);
    return null;
  } catch (error) {
    functions.logger.error(`Failed to purge data for ${userId}:`, error);
    return null;
  }
});

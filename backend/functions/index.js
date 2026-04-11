const functions = require("firebase-functions");
const admin = require("firebase-admin");
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

exports.getQuotes = functions.https.onRequest(async (req, res) => {
  try {
    const limit = parseInt(req.query.limit) || 20;
    const category = req.query.category;

    let query = db.collection("quotes").limit(limit);
    if (category) {
      query = query.where("category", "==", category);
    }

    const snapshot = await query.get();
    const quotes = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));

    return createResponse(res, 200, quotes);
  } catch (error) {
    console.error("Error fetching quotes:", error);
    return createResponse(res, 500, null, "Failed to retrieve quotes");
  }
});

exports.getDailyQuote = functions.https.onRequest(async (req, res) => {
  try {
    const today = new Date().toISOString().split("T")[0];
    const docRef = await db.collection("daily_quotes").doc(today).get();

    if (!docRef.exists) {
      // Fallback: Return a popular quote if daily quote isn't set
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
    console.error("Error fetching daily quote:", error);
    return createResponse(res, 500, null, "Internal Server Error");
  }
});

exports.toggleFavorite = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated", "Must be logged in to favorite a quote"
    );
  }

  const userId = context.auth.uid;
  const { quoteId, action } = data; // action: 'add' or 'remove'

  if (!quoteId || !action) {
    throw new functions.https.HttpsError(
      "invalid-argument", "Missing quoteId or action parameters"
    );
  }

  try {
    const userRef = db.collection("users").doc(userId);
    const quoteRef = db.collection("quotes").doc(quoteId);

    await db.runTransaction(async (t) => {
      const userDoc = await t.get(userRef);
      if (!userDoc.exists) {
        throw new functions.https.HttpsError("not-found", "User not found");
      }

      const favorites = userDoc.data().favorite_quotes || [];

      if (action === "add" && !favorites.includes(quoteId)) {
        favorites.push(quoteId);
        t.update(userRef, { favorite_quotes: favorites });
        t.update(quoteRef, { popularity_score: admin.firestore.FieldValue.increment(1) });
      } else if (action === "remove" && favorites.includes(quoteId)) {
        const newFavorites = favorites.filter(id => id !== quoteId);
        t.update(userRef, { favorite_quotes: newFavorites });
        t.update(quoteRef, { popularity_score: admin.firestore.FieldValue.increment(-1) });
      }
    });

    return { success: true, message: `Successfully ${action}ed favorite.` };
  } catch (error) {
    console.error("Error toggling favorite:", error);
    throw new functions.https.HttpsError("internal", error.message);
  }
});

exports.logShare = functions.https.onCall(async (data, context) => {
  const { quoteId } = data;
  if (!quoteId) {
    throw new functions.https.HttpsError("invalid-argument", "Missing quoteId");
  }

  try {
    await db.collection("quotes").doc(quoteId).update({
      popularity_score: admin.firestore.FieldValue.increment(2) // Shares give more points
    });

    return { success: true };
  } catch (error) {
    console.error("Error logging share:", error);
    throw new functions.https.HttpsError("internal", error.message);
  }
});

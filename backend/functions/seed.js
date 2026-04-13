const admin = require("firebase-admin");
const serviceAccount = require("./serviceAccountKey.json"); // Provide your own service account key

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

const quotes = [
  { id: 'q_res_1', text: 'You have power over your mind - not outside events. Realize this, and you will find strength.', author: 'Marcus Aurelius', category: 'Resilience', popularity_score: 420 },
  { id: 'q_res_2', text: 'He who has a why to live for can bear almost any how.', author: 'Friedrich Nietzsche', category: 'Resilience', popularity_score: 385 },
  { id: 'q_res_3', text: 'The gem cannot be polished without friction, nor man perfected without trials.', author: 'Seneca', category: 'Resilience', popularity_score: 310 },
  { id: 'q_res_4', text: 'Hardships often prepare ordinary people for an extraordinary destiny.', author: 'C.S. Lewis', category: 'Resilience', popularity_score: 295 },
  { id: 'q_foc_1', text: 'Starve your distractions, feed your focus.', author: 'Daniel Goleman', category: 'Focus', popularity_score: 450 },
  { id: 'q_foc_2', text: 'The successful warrior is the average man, with laser-like focus.', author: 'Bruce Lee', category: 'Focus', popularity_score: 500 },
  { id: 'q_foc_3', text: 'Concentrate all your thoughts upon the work at hand. The sun\'s rays do not burn until brought to a focus.', author: 'Alexander Graham Bell', category: 'Focus', popularity_score: 330 },
  { id: 'q_foc_4', text: 'Lack of direction, not lack of time, is the problem. We all have twenty-four hour days.', author: 'Zig Ziglar', category: 'Focus', popularity_score: 410 },
  { id: 'q_min_1', text: 'Peace comes from within. Do not seek it without.', author: 'Buddha', category: 'Mindfulness', popularity_score: 520 },
  { id: 'q_min_2', text: 'Worry does not empty tomorrow of its sorrow. It empties today of its strength.', author: 'Corrie Ten Boom', category: 'Mindfulness', popularity_score: 480 },
  { id: 'q_min_3', text: 'Smile, breathe and go slowly.', author: 'Thich Nhat Hanh', category: 'Mindfulness', popularity_score: 390 },
  { id: 'q_min_4', text: 'The present moment is the only time over which we have dominion.', author: 'Thích Nhất Hạnh', category: 'Mindfulness', popularity_score: 345 },
  { id: 'q_gro_1', text: 'The only limit to our realization of tomorrow will be our doubts of today.', author: 'Franklin D. Roosevelt', category: 'Growth', popularity_score: 375 },
  { id: 'q_gro_2', text: 'Anyone who has never made a mistake has never tried anything new.', author: 'Albert Einstein', category: 'Growth', popularity_score: 510 },
  { id: 'q_gro_3', text: 'It does not matter how slowly you go as long as you do not stop.', author: 'Confucius', category: 'Growth', popularity_score: 490 },
  { id: 'q_gro_4', text: 'The mind is just like a muscle - the more you exercise it, the stronger it gets and the more it can expand.', author: 'Idowu Koyenikan', category: 'Growth', popularity_score: 280 }
];

async function seedDatabase() {
  console.log("Starting database seeding process...");
  const batch = db.batch();
  const quotesRef = db.collection('quotes');

  quotes.forEach((quote) => {
    const docRef = quotesRef.doc(quote.id);
    batch.set(docRef, {
      quote_id: quote.id,
      text: quote.text,
      author: quote.author,
      category: quote.category,
      popularity_score: quote.popularity_score,
      created_at: admin.firestore.FieldValue.serverTimestamp()
    });
  });

  try {
    await batch.commit();
    console.log(`Successfully seeded ${quotes.length} curated quotes into Firestore!`);
  } catch (error) {
    console.error("Error seeding database: ", error);
  }
}

seedDatabase();

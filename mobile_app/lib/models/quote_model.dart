class QuoteModel {
  final String quoteId;
  final String text;
  final String author;
  final String category;
  final int popularityScore;
  final DateTime? createdAt;

  QuoteModel({
    required this.quoteId,
    required this.text,
    required this.author,
    required this.category,
    this.popularityScore = 0,
    this.createdAt,
  });

  factory QuoteModel.fromMap(Map<String, dynamic> map) {
    return QuoteModel(
      quoteId: map['quote_id'] ?? '',
      text: map['text'] ?? '',
      author: map['author'] ?? 'Unknown',
      category: map['category'] ?? 'Motivation',
      popularityScore: map['popularity_score'] ?? 0,
      createdAt: map['created_at'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(map['created_at']) 
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quote_id': quoteId,
      'text': text,
      'author': author,
      'category': category,
      'popularity_score': popularityScore,
      'created_at': createdAt?.millisecondsSinceEpoch,
    };
  }

  // Curated Psychological Quote Dataset - Production Local Cache Fallback
  static List<QuoteModel> get initialList => [
    // Resilience & Stoicism
    QuoteModel(quoteId: 'q_res_1', text: 'You have power over your mind - not outside events. Realize this, and you will find strength.', author: 'Marcus Aurelius', category: 'Resilience', popularityScore: 420),
    QuoteModel(quoteId: 'q_res_2', text: 'He who has a why to live for can bear almost any how.', author: 'Friedrich Nietzsche', category: 'Resilience', popularityScore: 385),
    QuoteModel(quoteId: 'q_res_3', text: 'The gem cannot be polished without friction, nor man perfected without trials.', author: 'Seneca', category: 'Resilience', popularityScore: 310),
    QuoteModel(quoteId: 'q_res_4', text: 'Hardships often prepare ordinary people for an extraordinary destiny.', author: 'C.S. Lewis', category: 'Resilience', popularityScore: 295),
    
    // Focus & Productivity
    QuoteModel(quoteId: 'q_foc_1', text: 'Starve your distractions, feed your focus.', author: 'Daniel Goleman', category: 'Focus', popularityScore: 450),
    QuoteModel(quoteId: 'q_foc_2', text: 'The successful warrior is the average man, with laser-like focus.', author: 'Bruce Lee', category: 'Focus', popularityScore: 500),
    QuoteModel(quoteId: 'q_foc_3', text: 'Concentrate all your thoughts upon the work at hand. The sun\'s rays do not burn until brought to a focus.', author: 'Alexander Graham Bell', category: 'Focus', popularityScore: 330),
    QuoteModel(quoteId: 'q_foc_4', text: 'Lack of direction, not lack of time, is the problem. We all have twenty-four hour days.', author: 'Zig Ziglar', category: 'Focus', popularityScore: 410),

    // Mindfulness & Peace
    QuoteModel(quoteId: 'q_min_1', text: 'Peace comes from within. Do not seek it without.', author: 'Buddha', category: 'Mindfulness', popularityScore: 520),
    QuoteModel(quoteId: 'q_min_2', text: 'Worry does not empty tomorrow of its sorrow. It empties today of its strength.', author: 'Corrie Ten Boom', category: 'Mindfulness', popularityScore: 480),
    QuoteModel(quoteId: 'q_min_3', text: 'Smile, breathe and go slowly.', author: 'Thich Nhat Hanh', category: 'Mindfulness', popularityScore: 390),
    QuoteModel(quoteId: 'q_min_4', text: 'The present moment is the only time over which we have dominion.', author: 'Thích Nhất Hạnh', category: 'Mindfulness', popularityScore: 345),

    // Growth Mindset
    QuoteModel(quoteId: 'q_gro_1', text: 'The only limit to our realization of tomorrow will be our doubts of today.', author: 'Franklin D. Roosevelt', category: 'Growth', popularityScore: 375),
    QuoteModel(quoteId: 'q_gro_2', text: 'Anyone who has never made a mistake has never tried anything new.', author: 'Albert Einstein', category: 'Growth', popularityScore: 510),
    QuoteModel(quoteId: 'q_gro_3', text: 'It does not matter how slowly you go as long as you do not stop.', author: 'Confucius', category: 'Growth', popularityScore: 490),
    QuoteModel(quoteId: 'q_gro_4', text: 'The mind is just like a muscle - the more you exercise it, the stronger it gets and the more it can expand.', author: 'Idowu Koyenikan', category: 'Growth', popularityScore: 280),
  ];
}

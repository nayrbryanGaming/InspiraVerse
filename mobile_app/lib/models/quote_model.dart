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

  // Helper method for dummy data initialization while Firebase is not connected yet
  static List<QuoteModel> get initialList => [
    QuoteModel(
      quoteId: 'q_1',
      text: 'The only way to do great work is to love what you do.',
      author: 'Steve Jobs',
      category: 'Success',
      popularityScore: 100,
      createdAt: DateTime.now(),
    ),
    QuoteModel(
      quoteId: 'q_2',
      text: 'Believe you can and you are halfway there.',
      author: 'Theodore Roosevelt',
      category: 'Motivation',
      popularityScore: 95,
      createdAt: DateTime.now(),
    ),
    QuoteModel(
      quoteId: 'q_3',
      text: 'Quality is not an act, it is a habit.',
      author: 'Aristotle',
      category: 'Wisdom',
      popularityScore: 88,
      createdAt: DateTime.now(),
    ),
  ];
}

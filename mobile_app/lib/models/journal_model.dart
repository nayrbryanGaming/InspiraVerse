class JournalModel {
  final String quoteId;
  final String reflection;
  final DateTime date;

  JournalModel({
    required this.quoteId,
    required this.reflection,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'quote_id': quoteId,
      'reflection': reflection,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory JournalModel.fromMap(Map<String, dynamic> map) {
    return JournalModel(
      quoteId: map['quote_id'] ?? '',
      reflection: map['reflection'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] ?? 0),
    );
  }
}

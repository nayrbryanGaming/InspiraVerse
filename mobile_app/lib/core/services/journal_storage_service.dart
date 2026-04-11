import 'package:hive_flutter/hive_flutter.dart';
import '../constants/app_constants.dart';

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

class JournalStorageService {
  static const String _boxName = 'journal_box';
  static late Box<Map> _box;

  static Future<void> initialize() async {
    _box = await Hive.openBox<Map>(_boxName);
  }

  static List<JournalModel> getJournals() {
    return _box.values
        .map((map) => JournalModel.fromMap(Map<String, dynamic>.from(map)))
        .toList();
  }

  static Future<void> saveJournal(String quoteId, String reflection) async {
    final entry = JournalModel(
      quoteId: quoteId,
      reflection: reflection,
      date: DateTime.now(),
    );
    await _box.put(quoteId, entry.toMap());
  }

  static JournalModel? getJournalForQuote(String quoteId) {
    final map = _box.get(quoteId);
    if (map == null) return null;
    return JournalModel.fromMap(Map<String, dynamic>.from(map));
  }

  static bool hasJournaledToday() {
    final now = DateTime.now();
    return _box.values.any((map) {
      final date = DateTime.fromMillisecondsSinceEpoch(map['date'] ?? 0);
      return date.year == now.year && date.month == now.month && date.day == now.day;
    });
  }

  static Future<void> clearAll() async {
    await _box.clear();
  }
}

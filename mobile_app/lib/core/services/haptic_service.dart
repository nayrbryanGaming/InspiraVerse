import 'package:flutter/services.dart';

class HapticService {
  /// Subtle light impact for minor interactions
  static Future<void> light() async {
    await HapticFeedback.lightImpact();
  }

  /// Medium impact for buttons and significant UI changes
  static Future<void> medium() async {
    await HapticFeedback.mediumImpact();
  }

  /// Heavy impact for critical successes or warnings
  static Future<void> heavy() async {
    await HapticFeedback.heavyImpact();
  }

  /// Special "Success" sequence
  static Future<void> success() async {
    await HapticFeedback.mediumImpact();
    await Future.delayed(const Duration(milliseconds: 50));
    await HapticFeedback.lightImpact();
  }

  /// Special "Selection" feedback
  static Future<void> selection() async {
    await HapticFeedback.selectionClick();
  }
}

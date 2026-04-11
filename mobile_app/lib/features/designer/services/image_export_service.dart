import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:logger/logger.dart';

class ImageExportService {
  final ScreenshotController _screenshotController = ScreenshotController();
  final Logger _logger = Logger();

  ScreenshotController get controller => _screenshotController;

  Future<void> shareScreenshot(Uint8List bytes, {String? text}) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/quote_${DateTime.now().millisecondsSinceEpoch}.png').create();
      await imagePath.writeAsBytes(bytes);

      await Share.shareXFiles(
        [XFile(imagePath.path)],
        text: text ?? 'Shared via InspiraVerse ✨',
      );
    } catch (e) {
      _logger.e('Error sharing screenshot: $e');
    }
  }

  Future<String?> saveToGallery(Uint8List bytes) async {
    try {
      // In a real production app, we would use image_gallery_saver here.
      // For now, we save to documents and log the path.
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/InspiraVerse_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes);
      return file.path;
    } catch (e) {
      _logger.e('Error saving to gallery: $e');
      return null;
    }
  }
}

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
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/InspiraVerse_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes);
      
      // On Android, we can trigger a media scan to make it appear in gallery
      // For now, we return the path which can be used by Share.shareXFiles
      return file.path;
    } catch (e) {
      _logger.e('Error preparing for gallery: $e');
      return null;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../../../models/quote_model.dart';
import '../../../../core/constants/app_constants.dart';

class ShareCardPage extends StatefulWidget {
  final String quoteId;

  const ShareCardPage({super.key, required this.quoteId});

  @override
  State<ShareCardPage> createState() => _ShareCardPageState();
}

class _ShareCardPageState extends State<ShareCardPage> {
  final ScreenshotController _screenshotController = ScreenshotController();
  int _currentGradientIndex = 0;

  @override
  Widget build(BuildContext context) {
    final quote = QuoteModel.initialList.firstWhere(
      (q) => q.quoteId == widget.quoteId,
      orElse: () => QuoteModel.initialList.first,
    );

    final colors = AppConstants.shareCardGradients[_currentGradientIndex]
        .map((c) => Color(c))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Quote'),
        actions: [
          TextButton(
            onPressed: () async {
              final image = await _screenshotController.capture();
              if (image != null) {
                final directory = await getApplicationDocumentsDirectory();
                final imagePath = await File('${directory.path}/quote.png').create();
                await imagePath.writeAsBytes(image);
                await Share.shareXFiles(
                  [XFile(imagePath.path)],
                  text: '"${quote.text}" - ${quote.author}\n\nShared via InspiraVerse',
                );
              }
            },
            child: const Text('Share'),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Screenshot(
                  controller: _screenshotController,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: colors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        )
                      ],
                    ),
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.format_quote_rounded, color: Colors.white, size: 60),
                        const SizedBox(height: 16),
                        Text(
                          quote.text,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                height: 1.4,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          '- ${quote.author}',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.white70,
                              ),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.star, color: Colors.white54, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              'InspiraVerse',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Colors.white54,
                                    letterSpacing: 1.5,
                                  ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 100,
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: AppConstants.shareCardGradients.length,
              itemBuilder: (context, index) {
                final gradColors = AppConstants.shareCardGradients[index]
                    .map((c) => Color(c))
                    .toList();
                return GestureDetector(
                  onTap: () => setState(() => _currentGradientIndex = index),
                  child: Container(
                    width: 60,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: gradColors),
                      border: Border.all(
                        color: _currentGradientIndex == index
                            ? Colors.white
                            : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

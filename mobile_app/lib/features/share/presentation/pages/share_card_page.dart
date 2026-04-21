import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import '../../../../models/quote_model.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/quote_service.dart';
import '../../../../core/services/haptic_service.dart';
import '../../../../core/theme/app_theme.dart';

class ShareCardPage extends StatefulWidget {
  final String quoteId;
  final QuoteModel? quote;

  const ShareCardPage({super.key, required this.quoteId, this.quote});

  @override
  State<ShareCardPage> createState() => _ShareCardPageState();
}

class _ShareCardPageState extends State<ShareCardPage> {
  final ScreenshotController _screenshotController = ScreenshotController();
  int _currentGradientIndex = 0;
  QuoteModel? _fetchedQuote;

  @override
  void initState() {
    super.initState();
    _fetchedQuote = widget.quote;
    if (_fetchedQuote == null) {
      _loadQuote();
    }
  }

  void _loadQuote() {
    try {
      final local = QuoteModel.initialList.firstWhere((q) => q.quoteId == widget.quoteId);
      setState(() => _fetchedQuote = local);
    } catch (_) {
      // Fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    final quote = _fetchedQuote;

    if (quote == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final colors = AppConstants.shareCardGradients[_currentGradientIndex]
        .map((c) => Color(c))
        .toList();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text('Craft Your Message', style: GoogleFonts.outfit(fontWeight: FontWeight.w700)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: TextButton.icon(
              onPressed: () async {
                await HapticService.heavy();
                final image = await _screenshotController.capture();
                if (image != null) {
                  final directory = await getTemporaryDirectory();
                  final imagePath = await File('${directory.path}/inspiraverse_quote_${quote.quoteId}.png').create();
                  await imagePath.writeAsBytes(image);
                  
                  // Log share to backend
                  await QuoteService.logShare(quote.quoteId);
                  
                  await Share.shareXFiles(
                    [XFile(imagePath.path)],
                    text: '"${quote.text}" - ${quote.author}\n\nShared via InspiraVerse ✨',
                  );
                }
              },
              icon: const Icon(Icons.send_rounded, size: 18),
              label: const Text('SHARE'),
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.primary,
                textStyle: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 13),
              ),
            ),
          ),
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
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: colors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: colors.first.withOpacity(0.3),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        )
                      ],
                    ),
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.format_quote_rounded, color: Colors.white.withOpacity(0.4), size: 50),
                        const SizedBox(height: 24),
                        Text(
                          quote.text,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        Container(width: 40, height: 2, color: Colors.white30),
                        const SizedBox(height: 24),
                        Text(
                          quote.author.toUpperCase(),
                          style: GoogleFonts.outfit(
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 48),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.auto_awesome, color: Colors.white54, size: 14),
                            const SizedBox(width: 8),
                            Text(
                              'INSPIRAVERSE',
                              style: GoogleFonts.outfit(
                                color: Colors.white54,
                                fontWeight: FontWeight.w900,
                                fontSize: 9,
                                letterSpacing: 3,
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
            height: 120,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: AppConstants.shareCardGradients.length,
              itemBuilder: (context, index) {
                final gradColors = AppConstants.shareCardGradients[index]
                    .map((c) => Color(c))
                    .toList();
                final isSelected = _currentGradientIndex == index;
                
                return GestureDetector(
                  onTap: () {
                    HapticService.selection();
                    setState(() => _currentGradientIndex = index);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 56,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: gradColors),
                      border: Border.all(
                        color: isSelected ? AppTheme.primary : Colors.transparent,
                        width: 3,
                      ),
                      boxShadow: isSelected ? [
                        BoxShadow(color: AppTheme.primary.withOpacity(0.4), blurRadius: 10)
                      ] : [],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

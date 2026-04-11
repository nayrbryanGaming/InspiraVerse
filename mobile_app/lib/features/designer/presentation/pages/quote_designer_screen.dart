import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screenshot/screenshot.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/image_export_service.dart';
import '../../../../core/theme/app_theme.dart';

class QuoteDesignerScreen extends ConsumerStatefulWidget {
  const QuoteDesignerScreen({super.key});

  @override
  ConsumerState<QuoteDesignerScreen> createState() => _QuoteDesignerScreenState();
}

class _QuoteDesignerScreenState extends ConsumerState<QuoteDesignerScreen> {
  final _screenshotController = ScreenshotController();
  final _textController = TextEditingController(text: "Your daily inspiration starts with a single thought.");
  final _authorController = TextEditingController(text: "InspiraVerse");
  
  Color _backgroundColor = AppTheme.primary;
  Color _textColor = Colors.white;
  double _fontSize = 28;
  TextAlign _textAlign = TextAlign.center;
  bool _isGradient = true;

  final List<Color> _presetColors = [
    AppTheme.primary,
    const Color(0xFF8B5CF6),
    const Color(0xFFEC4899),
    const Color(0xFFF59E0B),
    const Color(0xFF10B981),
    const Color(0xFF3B82F6),
    const Color(0xFF1F2937),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Designer Studio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_rounded),
            onPressed: _captureAndShare,
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
                    aspectRatio: 1,
                    decoration: BoxDecoration(
                      color: _backgroundColor,
                      borderRadius: BorderRadius.circular(24),
                      gradient: _isGradient 
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [_backgroundColor, _backgroundColor.withOpacity(0.7)],
                          )
                        : null,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.format_quote_rounded, color: Colors.white60, size: 48),
                        const SizedBox(height: 20),
                        Text(
                          _textController.text,
                          textAlign: _textAlign,
                          style: GoogleFonts.outfit(
                            fontSize: _fontSize,
                            fontWeight: FontWeight.w700,
                            color: _textColor,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "— ${_authorController.text}",
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: _textColor.withOpacity(0.8),
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Content'),
          TextField(
            controller: _textController,
            onChanged: (v) => setState(() {}),
            decoration: const InputDecoration(hintText: 'Enter quote text...'),
            maxLines: 2,
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('Appearance'),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _presetColors.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final color = _presetColors[index];
                return GestureDetector(
                  onTap: () => setState(() => _backgroundColor = color),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _backgroundColor == color ? Colors.white : Colors.transparent,
                        width: 3,
                      ),
                      boxShadow: [
                        if (_backgroundColor == color)
                          BoxShadow(color: color.withOpacity(0.4), blurRadius: 8, spreadRadius: 2),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildControlIcon(Icons.format_align_left, _textAlign == TextAlign.left, () => setState(() => _textAlign = TextAlign.left)),
              _buildControlIcon(Icons.format_align_center, _textAlign == TextAlign.center, () => setState(() => _textAlign = TextAlign.center)),
              _buildControlIcon(Icons.format_align_right, _textAlign == TextAlign.right, () => setState(() => _textAlign = TextAlign.right)),
              const Spacer(),
              _buildControlIcon(Icons.gradient_rounded, _isGradient, () => setState(() => _isGradient = !_isGradient)),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          letterSpacing: 1.5,
          fontWeight: FontWeight.w800,
          color: AppTheme.textTertiary,
        ),
      ),
    );
  }

  Widget _buildControlIcon(IconData icon, bool isActive, VoidCallback onTap) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon),
      color: isActive ? AppTheme.primary : AppTheme.textTertiary,
    );
  }

  Future<void> _captureAndShare() async {
    final bytes = await _screenshotController.capture();
    if (bytes != null) {
      await ImageExportService().shareScreenshot(
        bytes,
        text: "Created with InspiraVerse Designer 🎨✨",
      );
    }
  }
}

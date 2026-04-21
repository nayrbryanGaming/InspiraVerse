import 'dart:ui';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screenshot/screenshot.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/image_export_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/haptic_service.dart';

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
  int _selectedTexture = 0; // 0: None, 1: Grain, 2: Minimalist Dots, 3: Soft Paper

  // Textured patterns now rendered via TexturePainter for 100% offline reliability
  final List<String> _textures = [
    'None',
    'Fine Grain',
    'Mindful Dots',
    'Linear Focus',
  ];

  final List<Color> _presetColors = [
    AppTheme.primary,
    const Color(0xFF8B5CF6),
    const Color(0xFFEC4899),
    const Color(0xFFF59E0B),
    const Color(0xFF10B981),
    const Color(0xFF3B82F6),
    const Color(0xFF1F2937),
  ];

  int _activeTab = 0; // 0: Text, 1: Style, 2: Layout
  String _selectedFont = 'Outfit';
  
  final List<String> _premiumFonts = [
    'Outfit',
    'Playfair Display',
    'Dancing Script',
    'Montserrat',
    'Caveat',
    'Cinzel',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Designer Studio'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
              ),
              child: const Icon(Icons.share_rounded, size: 20, color: AppTheme.primary),
            ),
            onPressed: () {
              HapticService.medium();
              _captureAndShare();
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.primary.withOpacity(0.05),
              AppTheme.background,
            ],
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 100, 24, 24),
                child: Center(
                  child: Screenshot(
                    controller: _screenshotController,
                    child: Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 500, minHeight: 400),
                      decoration: BoxDecoration(
                        color: _backgroundColor,
                        borderRadius: BorderRadius.circular(32),
                        gradient: _isGradient 
                          ? LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                _backgroundColor,
                                Color.lerp(_backgroundColor, Colors.black, 0.2) ?? _backgroundColor,
                              ],
                            )
                          : null,
                        boxShadow: [
                          BoxShadow(
                            color: _backgroundColor.withOpacity(0.3),
                            blurRadius: 40,
                            offset: const Offset(0, 20),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          if (_selectedTexture > 0)
                            Positioned.fill(
                              child: CustomPaint(
                                painter: TexturePainter(
                                  type: _selectedTexture,
                                  color: _textColor.withOpacity(0.05),
                                ),
                               ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(48),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      _textController.text,
                                      textAlign: _textAlign,
                                      style: GoogleFonts.getFont(
                                        _selectedFont,
                                        color: _textColor,
                                        fontSize: _fontSize,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Row(
                                      mainAxisAlignment: _getAlignmentMainAxisAlignment(),
                                      children: [
                                        Container(width: 20, height: 1, color: _textColor.withOpacity(0.5)),
                                        const SizedBox(width: 8),
                                        Text(
                                          _authorController.text,
                                          style: GoogleFonts.outfit(
                                            color: _textColor.withOpacity(0.8),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // Auto-Brand Watermark
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: _textColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: _textColor.withOpacity(0.1)),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.auto_awesome_rounded, color: _textColor.withOpacity(0.5), size: 10),
                                        const SizedBox(width: 6),
                                        Text(
                                          'INSPIRAVERSE',
                                          style: GoogleFonts.outfit(
                                            color: _textColor.withOpacity(0.5),
                                            fontSize: 8,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              _buildPremiumControls(),
            ],
          ),
        ),
      ),
    );
  }

  MainAxisAlignment _getAlignmentMainAxisAlignment() {
    switch (_textAlign) {
      case TextAlign.left: return MainAxisAlignment.start;
      case TextAlign.right: return MainAxisAlignment.end;
      default: return MainAxisAlignment.center;
    }
  }

  Widget _buildPremiumControls() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.darkSurface.withOpacity(0.7),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 40,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTabItem(0, 'TEXT', Icons.text_fields_rounded),
                      _buildTabItem(1, 'STYLE', Icons.palette_rounded),
                      _buildTabItem(2, 'LAYOUT', Icons.layers_rounded),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Divider(height: 1, color: Colors.white10),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.0, 0.1),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: _activeTab == 0
                        ? _buildTextTab()
                        : _activeTab == 1
                            ? _buildStyleTab()
                            : _buildLayoutTab(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(int index, String label, IconData icon) {
    final isActive = _activeTab == index;
    return GestureDetector(
      onTap: () {
        HapticService.selection();
        setState(() => _activeTab = index);
      },
      child: Column(
        children: [
          const SizedBox(height: 8),
          Icon(icon, color: isActive ? AppTheme.primaryLight : Colors.white54, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: isActive ? AppTheme.primaryLight : Colors.white54,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          if (isActive)
            Container(width: 20, height: 3, decoration: BoxDecoration(color: AppTheme.primaryLight, borderRadius: BorderRadius.circular(2))),
        ],
      ),
    );
  }

  Widget _buildTextTab() {
    return Column(
      key: const ValueKey(0),
      children: [
        TextField(
          controller: _textController,
          onChanged: (v) => setState(() {}),
          maxLines: 2,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Share your wisdom...',
            hintStyle: const TextStyle(color: Colors.white38),
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _authorController,
          onChanged: (v) => setState(() {}),
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Author name',
            hintStyle: const TextStyle(color: Colors.white38),
            prefixText: '— ',
            prefixStyle: const TextStyle(color: Colors.white54),
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  Widget _buildStyleTab() {
    return Column(
      key: const ValueKey(1),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('COLORS'),
        SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _presetColors.length,
            separatorBuilder: (context, index) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final color = _presetColors[index];
              return GestureDetector(
                onTap: () {
                  HapticService.light();
                  setState(() => _backgroundColor = color);
                },
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(color: _backgroundColor == color ? Colors.black : Colors.transparent, width: 2),
                    boxShadow: [
                      if (_backgroundColor == color)
                        BoxShadow(color: color.withOpacity(0.4), blurRadius: 10),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        _buildSectionTitle('TYPOGRAPHY'),
        SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _premiumFonts.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final font = _premiumFonts[index];
              final isSelected = _selectedFont == font;
              return ActionChip(
                label: Text(font, style: GoogleFonts.getFont(font, fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                backgroundColor: isSelected ? AppTheme.primaryLight : Colors.white.withOpacity(0.05),
                labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.white70),
                side: BorderSide.none,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                onPressed: () {
                  HapticService.selection();
                  setState(() => _selectedFont = font);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLayoutTab() {
    return Column(
      key: const ValueKey(2),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle('ALIGNMENT'),
            Row(
              children: [
                _buildControlIcon(Icons.format_align_left_rounded, _textAlign == TextAlign.left, () {
                   HapticService.selection();
                   setState(() => _textAlign = TextAlign.left);
                }),
                _buildControlIcon(Icons.format_align_center_rounded, _textAlign == TextAlign.center, () {
                   HapticService.selection();
                   setState(() => _textAlign = TextAlign.center);
                }),
                _buildControlIcon(Icons.format_align_right_rounded, _textAlign == TextAlign.right, () {
                   HapticService.selection();
                   setState(() => _textAlign = TextAlign.right);
                }),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle('TEXT SIZE'),
            Expanded(
              child: Slider(
                value: _fontSize,
                min: 16,
                max: 48,
                activeColor: AppTheme.primary,
                inactiveColor: AppTheme.primary.withOpacity(0.1),
                onChanged: (v) {
                  // Reduced frequency of haptics for slider
                  if ((v - _fontSize).abs() > 2) HapticService.light();
                  setState(() => _fontSize = v);
                },
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle('GRADIENT BACKGROUND'),
            Switch(
              value: _isGradient,
              onChanged: (v) {
                HapticService.light();
                setState(() => _isGradient = v);
              },
              activeColor: AppTheme.primary,
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildSectionTitle('TEXTURE OVERLAY'),
        SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final isSelected = _selectedTexture == index;
              return ActionChip(
                label: Text(
                  index == 0 ? 'Pure' : 'Texture $index',
                  style: TextStyle(fontSize: 10, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
                ),
                backgroundColor: isSelected ? AppTheme.primaryLight : Colors.white.withOpacity(0.05),
                labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.white70),
                side: BorderSide.none,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  HapticService.selection();
                  setState(() => _selectedTexture = index);
                },
              );
            },
          ),
        ),
      ],
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
          color: Colors.white54,
        ),
      ),
    );
  }

  Widget _buildControlIcon(IconData icon, bool isActive, VoidCallback onTap) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon),
      color: isActive ? AppTheme.primaryLight : Colors.white54,
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

class TexturePainter extends CustomPainter {
  final int type;
  final Color color;

  TexturePainter({required this.type, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0;

    switch (type) {
      case 1: // Fine Grain
        final rand = 42; // Deterministic seed
        for (double i = 0; i < size.width; i += 4) {
          for (double j = 0; j < size.height; j += 4) {
            // Pseudo-random dots
            if ((i * j + rand) % 7 < 2) {
              canvas.drawCircle(Offset(i, j), 0.5, paint);
            }
          }
        }
        break;
      case 2: // Mindful Dots
        for (double i = 0; i < size.width; i += 20) {
          for (double j = 0; j < size.height; j += 20) {
            canvas.drawCircle(Offset(i, j), 1.0, paint);
          }
        }
        break;
      case 3: // Linear Focus
        for (double i = 0; i < size.width; i += 10) {
          canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
        }
        break;
    }
  }

  @override
  bool shouldRepaint(covariant TexturePainter oldDelegate) => 
      oldDelegate.type != type || oldDelegate.color != color;
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../models/quote_model.dart';
import '../../../../core/theme/app_theme.dart';

class QuoteDetailPage extends StatefulWidget {
  final String quoteId;

  const QuoteDetailPage({super.key, required this.quoteId});

  @override
  State<QuoteDetailPage> createState() => _QuoteDetailPageState();
}

class _QuoteDetailPageState extends State<QuoteDetailPage> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    // Look up quote locally
    final quote = QuoteModel.initialList.firstWhere(
      (q) => q.quoteId == widget.quoteId,
      orElse: () => QuoteModel.initialList.first,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white.withOpacity(0.9)),
        actions: [
          IconButton(
            icon: Icon(Icons.share_rounded, color: Colors.white.withOpacity(0.9)),
            onPressed: () => context.push('/share/${widget.quoteId}'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          // Dynamic Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  AppTheme.primary,
                  Color.lerp(AppTheme.primary, Colors.black, 0.4)!,
                ],
              ),
            ),
          ),
          
          // Pattern Overlay
          Opacity(
            opacity: 0.05,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://www.transparenttextures.com/patterns/cubes.png'),
                  repeat: ImageRepeat.repeat,
                ),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.format_quote_rounded,
                            size: 60,
                            color: Colors.white.withOpacity(0.3),
                          ).animate().scale(delay: 200.ms).fadeIn(),
                          const SizedBox(height: 32),
                          Text(
                            quote.text,
                            style: GoogleFonts.outfit(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1.3,
                              letterSpacing: -0.5,
                            ),
                            textAlign: TextAlign.center,
                          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
                          const SizedBox(height: 48),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(width: 30, height: 1, color: Colors.white24),
                              const SizedBox(width: 16),
                              Text(
                                quote.author.toUpperCase(),
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white.withOpacity(0.8),
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Container(width: 30, height: 1, color: Colors.white24),
                            ],
                          ).animate().fadeIn(delay: 600.ms),
                          const SizedBox(height: 24),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              quote.category,
                              style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ).animate().fadeIn(delay: 800.ms).scale(),
                        ],
                      ),
                    ),
                  ),
                ),
              ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.9, 0.9)),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: Colors.white,
        elevation: 20,
        onPressed: () {
          setState(() => _isFavorited = !_isFavorited);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_isFavorited ? 'Saved to Wisdom Vault' : 'Removed from Favorites'),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              backgroundColor: AppTheme.primary,
            ),
          );
        },
        child: Icon(
          _isFavorited ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: AppTheme.primary,
          size: 32,
        ).animate(target: _isFavorited ? 1 : 0).scale(duration: 400.ms, curve: Curves.easeOutBack),
      ),
    );
  }
}

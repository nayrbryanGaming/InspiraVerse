import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../models/quote_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/quote_service.dart';
import '../../../../core/services/haptic_service.dart';

class QuoteDetailPage extends StatefulWidget {
  final String quoteId;
  final QuoteModel? quote;

  const QuoteDetailPage({super.key, required this.quoteId, this.quote});

  @override
  State<QuoteDetailPage> createState() => _QuoteDetailPageState();
}

class _QuoteDetailPageState extends State<QuoteDetailPage> {
  bool _isFavorited = false;
  QuoteModel? _fetchedQuote;

  @override
  void initState() {
    super.initState();
    _fetchedQuote = widget.quote;
    if (_fetchedQuote == null) {
      _loadQuote();
    }
  }

  Future<void> _loadQuote() async {
    // Attempt to find in local initialList first for instant load
    try {
      final local = QuoteModel.initialList.firstWhere((q) => q.quoteId == widget.quoteId);
      setState(() => _fetchedQuote = local);
    } catch (_) {
      // If not in initialList, we'd ideally fetch from Firestore
      // For now, we use the passed quote or fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    final quote = _fetchedQuote;

    if (quote == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

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
          // Dynamic Aura Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  AppTheme.primary,
                  Color.lerp(AppTheme.primary, Colors.black, 0.5)!,
                ],
              ),
            ),
          ),
          
          // Pattern Overlay (Subtle)
          Opacity(
            opacity: 0.05,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider('https://www.transparenttextures.com/patterns/cubes.png'),
                  repeat: ImageRepeat.repeat,
                ),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: Colors.white.withOpacity(0.15)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.format_quote_rounded,
                            size: 50,
                            color: Colors.white.withOpacity(0.2),
                          ).animate().scale(delay: 200.ms).fadeIn(),
                          const SizedBox(height: 32),
                          Text(
                            quote.text,
                            style: GoogleFonts.outfit(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1.4,
                              letterSpacing: -0.5,
                            ),
                            textAlign: TextAlign.center,
                          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.05),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(width: 24, height: 1, color: Colors.white24),
                              const SizedBox(width: 16),
                              Text(
                                quote.author.toUpperCase(),
                                style: GoogleFonts.outfit(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white.withOpacity(0.7),
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Container(width: 24, height: 1, color: Colors.white24),
                            ],
                          ).animate().fadeIn(delay: 600.ms),
                          const SizedBox(height: 24),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              quote.category.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white60, 
                                fontSize: 9, 
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ).animate().fadeIn(delay: 800.ms).scale(),
                        ],
                      ),
                    ),
                  ),
                ),
              ).animate().fadeIn(duration: 1.seconds).scale(begin: const Offset(0.95, 0.95)),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: Colors.white,
        elevation: 15,
        onPressed: () async {
          await HapticService.medium();
          final targetState = !_isFavorited;
          final success = await QuoteService.toggleFavorite(quote.quoteId, targetState);
          
          if (success && mounted) {
            setState(() => _isFavorited = targetState);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(_isFavorited ? 'Transferred to Wisdom Vault' : 'Removed from Sanctuary'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppTheme.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            );
          }
        },
        child: Icon(
          _isFavorited ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: _isFavorited ? Colors.redAccent : AppTheme.primary,
          size: 32,
        ).animate(target: _isFavorited ? 1 : 0).scale(duration: 400.ms, curve: Curves.easeOutBack),
      ),
    );
  }
}

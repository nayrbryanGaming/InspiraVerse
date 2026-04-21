import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/services/quote_service.dart';
import '../../../../models/quote_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/haptic_service.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CategoryQuotesPage extends StatefulWidget {
  final String category;

  const CategoryQuotesPage({super.key, required this.category});

  @override
  State<CategoryQuotesPage> createState() => _CategoryQuotesPageState();
}

class _CategoryQuotesPageState extends State<CategoryQuotesPage> {
  late Future<List<QuoteModel>> _quotesFuture;

  @override
  void initState() {
    super.initState();
    _quotesFuture = QuoteService.getQuotes(category: widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: FutureBuilder<List<QuoteModel>>(
        future: _quotesFuture,
        builder: (context, snapshot) {
          final quotes = snapshot.data ?? [];
          final isLoading = snapshot.connectionState == ConnectionState.waiting;

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildAppBar(),
              if (isLoading)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (quotes.isEmpty)
                SliverFillRemaining(
                  child: _buildEmptyState(),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final quote = quotes[index];
                        return _buildQuoteCard(context, quote, index);
                      },
                      childCount: quotes.length,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 140,
      backgroundColor: AppTheme.primary,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          '${widget.category} Wisdom',
          style: GoogleFonts.outfit(fontWeight: FontWeight.w800, color: Colors.white),
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: AppTheme.auraGradient,
          ),
          child: Center(
            child: const Opacity(
              opacity: 0.2,
              child: Icon(Icons.auto_awesome_rounded, size: 100, color: Colors.white),
            ),
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  Widget _buildQuoteCard(BuildContext context, QuoteModel quote, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.primary.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20, offset: const Offset(0, 10))
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            HapticService.light();
            context.push('/quote/${quote.quoteId}');
          },
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.format_quote_rounded, color: AppTheme.primary.withOpacity(0.2), size: 30),
                const SizedBox(height: 12),
                Text(
                  quote.text,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(width: 12, height: 2, color: AppTheme.primary.withOpacity(0.3)),
                    const SizedBox(width: 8),
                    Text(
                      quote.author.toUpperCase(),
                      style: GoogleFonts.outfit(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textSecondary,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_rounded, size: 16, color: AppTheme.textTertiary),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: (index * 100).ms).slideX(begin: 0.1);
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.hourglass_empty_rounded, size: 60, color: AppTheme.textTertiary.withOpacity(0.3)),
        const SizedBox(height: 20),
        Text(
          'More Wisdom Loading...',
          style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w700, color: AppTheme.textSecondary),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'We are curating elite quotes for this category. Check back soon for your daily spark.',
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(color: AppTheme.textTertiary, fontSize: 13),
          ),
        ),
      ],
    ).animate().fadeIn();
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../models/quote_model.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/journal_storage_service.dart';
import '../../../../core/services/haptic_service.dart';
import '../providers/home_providers.dart';
import '../widgets/home_widgets.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String _selectedMood = 'All';
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (mounted) {
        setState(() => _scrollOffset = _scrollController.offset);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          HapticService.medium();
          context.push('/designer');
        },
        label: Text('Design Quote', style: GoogleFonts.outfit(fontWeight: FontWeight.w700)),
        icon: const Icon(Icons.palette_rounded),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ).animate().scale(delay: 1.seconds).shimmer(duration: 2.seconds),
      body: ref.watch(filteredQuotesProvider(_selectedMood)).when(
        data: (quotes) {
          final dailyQuote = quotes.isNotEmpty ? quotes.first : QuoteModel.initialList.first;

          return CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildAppBar(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      _buildHeader('How is your heart today?', context),
                      const SizedBox(height: 16),
                      MoodSelector(
                        selectedMood: _selectedMood,
                        onMoodSelected: (mood) => setState(() => _selectedMood = mood),
                      ),
                      const SizedBox(height: 32),
                      _buildHeader('Wisdom for the Soul', context),
                      const SizedBox(height: 16),
                      InspirationCard(
                        quote: dailyQuote,
                        onTap: () {
                          HapticService.light();
                          context.push('/quote/${dailyQuote.quoteId}');
                        },
                      ),
                      const SizedBox(height: 48),
                      _buildHeader('Daily Reflection', context),
                      const SizedBox(height: 16),
                      JournalReflectionCard(
                        quote: dailyQuote,
                        onSaved: () => setState(() {}),
                      ),
                      const SizedBox(height: 48),
                      _buildHeader('Your Resilience Journey', context),
                      const SizedBox(height: 16),
                      const ResilienceChart(),
                      const SizedBox(height: 48),
                      _buildHeader('Curated Wisdom', context),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SearchHeaderDelegate(),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final quote = quotes[index % quotes.length];
                      return _buildQuoteListItem(context, quote, index);
                    },
                    childCount: quotes.length,
                  ),
                ),
              ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 140,
      collapsedHeight: 80,
      stretch: true,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.blurBackground, StretchMode.zoomBackground],
        background: Stack(
          children: [
            Container(decoration: const BoxDecoration(gradient: AppTheme.auraGradient)),
            // Parallax Glow
            Positioned(
              top: -50 - (_scrollOffset * 0.2),
              right: -50,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ).animate(onPlay: (c) => c.repeat()).scale(duration: 3.seconds, curve: Curves.easeInOut),
            ),
          ],
        ),
        titlePadding: const EdgeInsets.only(left: 24, bottom: 20),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'InspiraVerse',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w900,
                fontSize: 24,
                color: Colors.white,
                letterSpacing: -1.0,
              ),
            ),
            Text(
              'Cultivating Inner Peace',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w500,
                fontSize: 10,
                color: Colors.white70,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
      actions: [
        _buildStreakBadge(),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () {
            HapticService.light();
            context.push('/profile');
          },
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_outline_rounded, size: 22, color: Colors.white),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildStreakBadge() {
    final streak = JournalStorageService.getStreak();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.local_fire_department_rounded, size: 18, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            '$streak',
            style: GoogleFonts.outfit(fontWeight: FontWeight.w900, fontSize: 15, color: Colors.white),
          ),
        ],
      ),
    ).animate().scale().shimmer(delay: 2.seconds);
  }

  Widget _buildHeader(String title, BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        fontWeight: FontWeight.w800,
        fontSize: 22,
        letterSpacing: -0.5,
        color: AppTheme.textPrimary,
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1);
  }

  Widget _buildQuoteListItem(BuildContext context, QuoteModel quote, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppTheme.primary.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 15, offset: const Offset(0, 8))
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(24),
        title: Text(
          quote.text,
          style: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 17, height: 1.4),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  quote.category.toUpperCase(),
                  style: GoogleFonts.outfit(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.primary,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Text(
                '— ${quote.author}',
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          HapticService.light();
          context.push('/quote/${quote.quoteId}');
        },
      ),
    ).animate().fadeIn(delay: (index * 80).ms, duration: 500.ms).slideY(begin: 0.1);
  }
}

class _SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: AppTheme.background.withOpacity(0.8),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Consumer(
            builder: (context, ref, child) {
              return TextField(
                onChanged: (value) => ref.read(searchControllerProvider.notifier).state = value,
                style: GoogleFonts.outfit(),
                decoration: InputDecoration(
                  hintText: 'Search wisdom...',
                  hintStyle: GoogleFonts.outfit(color: AppTheme.textTertiary),
                  prefixIcon: const Icon(Icons.search_rounded, color: AppTheme.primary, size: 22),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: AppTheme.primary.withOpacity(0.1)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: AppTheme.primary.withOpacity(0.1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: AppTheme.primary, width: 1.5),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 82;
  @override
  double get minExtent => 82;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

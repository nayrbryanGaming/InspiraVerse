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
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Color _getMoodColor(String mood) {
    switch (mood) {
      case 'Motivation': return AppTheme.primary;
      case 'Success': return const Color(0xFFF59E0B);
      case 'Mindfulness': return const Color(0xFF10B981);
      case 'Wisdom': return const Color(0xFF8B5CF6);
      case 'Resilience': return const Color(0xFFEC4899);
      case 'Focus': return const Color(0xFF3B82F6);
      default: return AppTheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final quotes = QuoteModel.initialList;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          HapticService.medium();
          context.push('/designer');
        },
        label: const Text('Create Custom'),
        icon: const Icon(Icons.palette_rounded),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ).animate().scale(delay: 1.seconds).shimmer(duration: 2.seconds),
      body: CustomScrollView(
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
                  _buildHeader('How are you feeling?', context),
                  const SizedBox(height: 16),
                  _buildMoodSelector(),
                  const SizedBox(height: 32),
                  _buildHeader('Daily Inspiration', context),
                  const SizedBox(height: 16),
                  _buildDailyCard(context, quotes.first),
                  const SizedBox(height: 32),
                  _buildHeader('Mindset Mirror', context),
                  const SizedBox(height: 16),
                  _buildJournalSection(quotes.first),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(
              child: _buildHeader('Refined for You', context),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
          const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      collapsedHeight: 70,
      stretch: true,
      pinned: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.blurBackground, StretchMode.zoomBackground],
        background: Stack(
          children: [
            AnimatedContainer(
              duration: 600.ms,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    _getMoodColor(_selectedMood).withOpacity(0.15),
                    AppTheme.background,
                  ],
                ),
              ),
            ),
            // Parallax Sparkle Layer
            Positioned(
              top: -_scrollOffset * 0.2,
              right: 20,
              child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, opacity: 0.1, size: 100)
                  .animate(onPlay: (c) => c.repeat())
                  .rotate(duration: 10.seconds)
                  .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2), duration: 2.seconds, curve: Curves.easeInOut),
            ),
          ],
        ),
        titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
        title: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'InspiraVerse',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                    color: AppTheme.primary,
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  'Your daily spark of wisdom',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: AppTheme.textSecondary.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => HapticService.light(),
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
              ],
            ),
            child: const Icon(Icons.notifications_none_rounded, size: 22, color: AppTheme.primary),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildHeader(String title, BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1);
  }

  Widget _buildMoodSelector() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: AppConstants.quoteCategories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final mood = AppConstants.quoteCategories[index];
          final isSelected = _selectedMood == mood;
          return GestureDetector(
            onTap: () {
              HapticService.selection();
              setState(() => _selectedMood = mood);
            },
            child: AnimatedContainer(
              duration: 300.ms,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primary : AppTheme.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [BoxShadow(color: AppTheme.primary.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))]
                    : [],
              ),
              alignment: Alignment.center,
              child: Text(
                '${AppConstants.categoryEmojis[mood]} $mood',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isSelected ? Colors.white : AppTheme.textSecondary,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
              ),
            ),
          ).animate().fadeIn(delay: (index * 50).ms);
        },
      ),
    );
  }

  Widget _buildDailyCard(BuildContext context, QuoteModel quote) {
    return GestureDetector(
      onTap: () {
        HapticService.light();
        context.push('/quote/${quote.quoteId}');
      },
      child: Container(
        height: 280,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: _getMoodColor(_selectedMood).withOpacity(0.2),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            children: [
              Image.network(
                'https://images.unsplash.com/photo-1499336315816-097655dcfbda?auto=format&fit=crop&q=80&w=1000',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ).animate().scale(begin: const Offset(1.0, 1.0), end: const Offset(1.1, 1.1), duration: 20.seconds),
              // Ultra-Premium Particles Overlay
              ...List.generate(5, (i) => Positioned(
                top: 50.0 + (i * 30),
                right: 30.0 + (i * 10),
                child: const Icon(Icons.auto_awesome, color: Colors.white, size: 8)
                    .animate(onPlay: (c) => c.repeat())
                    .fadeIn(duration: 1.seconds)
                    .then()
                    .fadeOut(delay: 1.seconds)
                    .then()
                    .moveY(begin: 0, end: -20, duration: 2.seconds),
              )),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'QUOTE OF THE DAY',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 10,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      quote.text,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                            height: 1.2,
                          ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage('https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100&h=100&fit=crop'),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          quote.author,
                          style: GoogleFonts.outfit(
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded, color: Colors.white.withOpacity(0.5), size: 16),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1, curve: Curves.easeOutCirc),
    );
  }

  Widget _buildJournalSection(QuoteModel quote) {
    final journal = JournalStorageService.getJournalForQuote(quote.quoteId);
    final isDone = journal != null;
    final controller = TextEditingController(text: journal?.reflection ?? '');

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.primary.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit_note_rounded, size: 20, color: AppTheme.primary),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daily Reflection',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    isDone ? 'Mindset set for today' : 'What does this mean to you?',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const Spacer(),
              if (isDone) const Icon(Icons.check_circle_rounded, color: AppTheme.success, size: 28).animate().scale().rotate(),
            ],
          ),
          const SizedBox(height: 20),
          if (!isDone)
            TextField(
              controller: controller,
              maxLines: 3,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Type your reflection here...',
                filled: true,
                fillColor: AppTheme.primary.withOpacity(0.02),
              ),
            ),
          if (isDone)
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                journal.reflection,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
              ),
            ),
          const SizedBox(height: 16),
          if (!isDone)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (controller.text.isNotEmpty) {
                    HapticService.success();
                    await JournalStorageService.saveJournal(quote.quoteId, controller.text);
                    setState(() {});
                  }
                },
                child: const Text('Save Reflection'),
              ),
            ),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms, duration: 400.ms);
  }

  Widget _buildQuoteListItem(BuildContext context, QuoteModel quote, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.primary.withOpacity(0.05)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        title: Text(
          quote.text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  quote.category,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.primary),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                quote.author,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        onTap: () {
          HapticService.light();
          context.push('/quote/${quote.quoteId}');
        },
      ),
    ).animate().fadeIn(delay: (index * 100).ms, duration: 400.ms).slideY(begin: 0.1);
  }
}

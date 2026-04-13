import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/services/journal_storage_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../models/journal_model.dart';
import '../../../../core/services/haptic_service.dart';

class GrowthDashboard extends ConsumerStatefulWidget {
  const GrowthDashboard({super.key});

  @override
  ConsumerState<GrowthDashboard> createState() => _GrowthDashboardState();
}

class _GrowthDashboardState extends ConsumerState<GrowthDashboard> {
  @override
  void initState() {
    super.initState();
    _triggerEntranceHaptics();
  }

  Future<void> _triggerEntranceHaptics() async {
    await HapticService.light();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticService.selection();
  }

  @override
  Widget build(BuildContext context) {
    final streak = JournalStorageService.getStreak();
    final journals = JournalStorageService.getJournals();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Evolution Architect', style: GoogleFonts.outfit(fontWeight: FontWeight.w800)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => HapticService.light(),
            icon: const Icon(Icons.share_rounded, color: AppTheme.primary),
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
              AppTheme.primary.withOpacity(0.08),
              AppTheme.background,
            ],
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(24, 120, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStreakCard(context, streak),
              const SizedBox(height: 32),
              _buildHeader('Consciousness Level'),
              const SizedBox(height: 16),
              _buildEvolutionProgress(journals.length),
              const SizedBox(height: 32),
              _buildHeader('Growth Metrics'),
              const SizedBox(height: 16),
              _buildStatGrid(context, journals.length),
              const SizedBox(height: 36),
              _buildHeader('Engagement Matrix'),
              const SizedBox(height: 16),
              _buildActivityHeatmap(context),
              const SizedBox(height: 36),
              _buildHeader('Timeline of Wisdom'),
              const SizedBox(height: 16),
              if (journals.isEmpty)
                _buildEmptyState(context)
              else
                ...journals.reversed.take(8).map((j) => _buildJournalItem(context, j)).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: GoogleFonts.outfit(
        fontSize: 12,
        fontWeight: FontWeight.w900,
        height: 1.2,
        color: AppTheme.textTertiary,
        letterSpacing: 1.5,
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1);
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color?.withOpacity(0.5),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppTheme.primary.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Icon(Icons.auto_fix_high_rounded, size: 48, color: AppTheme.primary.withOpacity(0.2)),
          const SizedBox(height: 16),
          Text(
            'Your story begins here.',
            style: GoogleFonts.outfit(fontWeight: FontWeight.w600, color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 8),
          const Text(
            'Start reflecting on quotes to track your growth.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: AppTheme.textTertiary),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakCard(BuildContext context, int streak) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: AppTheme.zenGradient,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.35),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Icon(Icons.wb_sunny_rounded, size: 120, color: Colors.white.withOpacity(0.1)),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.flash_on_rounded, color: Colors.white, size: 32)
                    .animate(onPlay: (c) => c.repeat())
                    .shimmer(duration: 2.seconds),
              ),
              const SizedBox(height: 20),
              Text(
                '$streak DAY STREAK',
                style: GoogleFonts.outfit(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'YOUR MINDSET IS EVOLVING',
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withOpacity(0.8),
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.9, 0.9), curve: Curves.easeOutBack);
  }

  Widget _buildStatGrid(BuildContext context, int totalLogs) {
    return Row(
      children: [
        Expanded(child: _buildStatItem(context, 'REFLECTIONS', '$totalLogs', Icons.edit_note_rounded)),
        const SizedBox(width: 16),
        Expanded(child: _buildStatItem(context, 'WISDOM XP', '${totalLogs * 100}', Icons.workspace_premium_rounded)),
      ],
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5)),
        ],
        border: Border.all(color: AppTheme.primary.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppTheme.primary, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.w700, color: AppTheme.textTertiary, letterSpacing: 1),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityHeatmap(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppTheme.primary.withOpacity(0.05)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(14, (i) {
              final opacity = (i % 3 == 0) ? 1.0 : (i % 2 == 0 ? 0.4 : 0.1);
              return Column(
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withOpacity(opacity),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ).animate().scale(delay: (i * 50).ms),
                  const SizedBox(height: 8),
                  Text(
                    ['M', 'T', 'W', 'T', 'F', 'S', 'S'][i % 7],
                    style: GoogleFonts.outfit(fontSize: 8, color: AppTheme.textTertiary, fontWeight: FontWeight.w600),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildJournalItem(BuildContext context, JournalModel journal) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.primary.withOpacity(0.05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.article_rounded, size: 18, color: AppTheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  journal.reflection,
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'REFLECTED ON ${journal.date.day}/${journal.date.month}/${journal.date.year}',
                  style: GoogleFonts.outfit(
                    fontSize: 9, 
                    fontWeight: FontWeight.w800, 
                    color: AppTheme.textTertiary,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1);
  }

  Widget _buildEvolutionProgress(int totalLogs) {
    final double progress = (totalLogs % 5) / 5.0;
    final int level = (totalLogs / 5).floor() + 1;
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(color: AppTheme.primary.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
        ],
        border: Border.all(color: AppTheme.primary.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LEVEL $level ARCHITECT',
                    style: GoogleFonts.outfit(fontWeight: FontWeight.w900, color: AppTheme.primary, fontSize: 16),
                  ),
                  Text(
                    'WISDOM PROGRESSION',
                    style: GoogleFonts.outfit(fontSize: 9, fontWeight: FontWeight.w800, color: AppTheme.textTertiary, letterSpacing: 1),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${(progress * 100).toInt()}%',
                  style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 14,
                  backgroundColor: AppTheme.primary.withOpacity(0.1),
                  valueColor: const AlwaysStoppedAnimation(AppTheme.primary),
                ),
              ),
              if (progress > 0)
                Positioned.fill(
                  child: const Center(child: Icon(Icons.auto_awesome, color: Colors.white, size: 8))
                      .animate(onPlay: (c) => c.repeat())
                      .shimmer(duration: 2.seconds),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '${5 - (totalLogs % 5)} more reflections to reach Level ${level + 1}',
            style: const TextStyle(fontSize: 10, color: AppTheme.textTertiary, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1);
  }
}

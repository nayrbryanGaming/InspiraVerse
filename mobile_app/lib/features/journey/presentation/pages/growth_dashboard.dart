import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/services/journal_storage_service.dart';
import '../../../../core/theme/app_theme.dart';

class GrowthDashboard extends ConsumerWidget {
  const GrowthDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streak = JournalStorageService.getStreak();
    final journals = JournalStorageService.getJournals();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mindset Journey'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStreakCard(context, streak),
            const SizedBox(height: 32),
            _buildStatGrid(context, journals.length),
            const SizedBox(height: 32),
            Text(
              'Your Activity',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),
            _buildActivityHeatmap(context),
            const SizedBox(height: 32),
            Text(
              'Recent Reflections',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),
            ...journals.reversed.take(5).map((j) => _buildJournalItem(context, j)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakCard(BuildContext context, int streak) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(color: AppTheme.primary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 48),
          const SizedBox(height: 16),
          Text(
            '$streak Day Streak',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            'Keep building your mental resilience!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    ).animate().fadeIn().scale();
  }

  Widget _buildStatGrid(BuildContext context, int totalLogs) {
    return Row(
      children: [
        Expanded(child: _buildStatItem(context, 'Total Refined', '$totalLogs', Icons.edit_calendar_rounded)),
        const SizedBox(width: 16),
        Expanded(child: _buildStatItem(context, 'Resilience Level', 'Lv. ${(totalLogs / 5).floor() + 1}', Icons.workspace_premium_rounded)),
      ],
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.primary.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.primary, size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.textTertiary),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityHeatmap(BuildContext context) {
    // Simplified heatmap simulation for MVP launch
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.primary.withOpacity(0.05)),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(14, (i) {
          final isCheck = i % 3 == 0;
          return Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: isCheck ? AppTheme.primary : AppTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildJournalItem(BuildContext context, JournalModel journal) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primary.withOpacity(0.02)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            journal.reflection,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 8),
          Text(
            '${journal.date.day}/${journal.date.month}/${journal.date.year}',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.textTertiary),
          ),
        ],
      ),
    ).animate().slideX(begin: 0.1);
  }
}

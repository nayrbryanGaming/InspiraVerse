import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../models/quote_model.dart';
import '../../../../core/services/journal_storage_service.dart';
import '../../../../core/services/haptic_service.dart';
import '../../../../core/constants/app_constants.dart';

class MoodSelector extends StatelessWidget {
  final String selectedMood;
  final Function(String) onMoodSelected;

  const MoodSelector({
    super.key,
    required this.selectedMood,
    required this.onMoodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: AppConstants.quoteCategories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final mood = AppConstants.quoteCategories[index];
          final isSelected = selectedMood == mood;
          return GestureDetector(
            onTap: () {
              HapticService.selection();
              onMoodSelected(mood);
            },
            child: AnimatedContainer(
              duration: 300.ms,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primary : AppTheme.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(24),
                boxShadow: isSelected
                    ? [BoxShadow(color: AppTheme.primary.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 6))]
                    : [],
              ),
              alignment: Alignment.center,
              child: Text(
                '${AppConstants.categoryEmojis[mood]} $mood',
                style: GoogleFonts.outfit(
                  color: isSelected ? Colors.white : AppTheme.textSecondary,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: 0.2);
        },
      ),
    );
  }
}

class InspirationCard extends StatelessWidget {
  final QuoteModel quote;
  final VoidCallback onTap;

  const InspirationCard({
    super.key,
    required this.quote,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 340,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withOpacity(0.25),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(36),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&q=80&w=1000',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(color: Colors.white),
                ),
              ).animate().scale(
                    begin: const Offset(1.0, 1.0),
                    end: const Offset(1.15, 1.15),
                    duration: 30.seconds,
                  ),
              // Premium Aura Overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.85),
                    ],
                  ),
                ),
              ),
              // Glassmorphism Header
              Positioned(
                top: 24,
                left: 24,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Text(
                        'DAILY SPARK',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                          letterSpacing: 2.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quote.text,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 26,
                        height: 1.2,
                        letterSpacing: -0.5,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        const Icon(Icons.format_quote_rounded, color: AppTheme.secondary, size: 24),
                        const SizedBox(width: 12),
                        Text(
                          quote.author,
                          style: GoogleFonts.outfit(
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppTheme.secondary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
                        ),
                      ],
                    ).animate().fadeIn(delay: 400.ms),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.95, 0.95));
  }
}

class JournalReflectionCard extends StatefulWidget {
  final QuoteModel quote;
  final VoidCallback onSaved;

  const JournalReflectionCard({
    super.key,
    required this.quote,
    required this.onSaved,
  });

  @override
  State<JournalReflectionCard> createState() => _JournalReflectionCardState();
}

class _JournalReflectionCardState extends State<JournalReflectionCard> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final journal = JournalStorageService.getJournalForQuote(widget.quote.quoteId);
    _controller = TextEditingController(text: journal?.reflection ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final journal = JournalStorageService.getJournalForQuote(widget.quote.quoteId);
    final isDone = journal != null;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppTheme.primary.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.auto_fix_high_rounded, size: 22, color: AppTheme.primary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Reflection',
                      style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 18),
                    ),
                    Text(
                      isDone ? 'Mindset set for today' : 'Apply this wisdom to your life',
                      style: GoogleFonts.outfit(fontSize: 13, color: AppTheme.textSecondary.withOpacity(0.7)),
                    ),
                  ],
                ),
              ),
              if (isDone) 
                const Icon(Icons.check_circle_rounded, color: AppTheme.success, size: 32)
                  .animate().scale(curve: Curves.elasticOut, duration: 800.ms),
            ],
          ),
          const SizedBox(height: 24),
          if (!isDone) ...[
            TextField(
              controller: _controller,
              maxLines: 4,
              style: GoogleFonts.outfit(fontSize: 16),
              decoration: InputDecoration(
                hintText: 'How can you embody this quote today?',
                hintStyle: GoogleFonts.outfit(color: AppTheme.textTertiary),
                filled: true,
                fillColor: AppTheme.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () async {
                  if (_controller.text.isNotEmpty) {
                    HapticService.success();
                    await JournalStorageService.saveJournal(widget.quote.quoteId, _controller.text);
                    widget.onSaved();
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  elevation: 0,
                ),
                child: Text('Seal the Mindset', style: GoogleFonts.outfit(fontWeight: FontWeight.w700)),
              ),
            ),
          ] else ...[
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.04),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.primary.withOpacity(0.05)),
              ),
              child: Text(
                journal.reflection,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: AppTheme.textPrimary,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1);
  }
}

class ResilienceChart extends StatelessWidget {
  const ResilienceChart({super.key});

  @override
  Widget build(BuildContext context) {
    final activity = JournalStorageService.getActivityMap();
    return Container(
      height: 160,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppTheme.primary.withOpacity(0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(7, (index) {
          final date = DateTime.now().subtract(Duration(days: 6 - index));
          final dateClean = DateTime(date.year, date.month, date.day);
          final count = activity[dateClean] ?? 0;
          final heightFactor = count > 0 ? 0.3 + (count * 0.23) : 0.08;
          final isToday = index == 6;

          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedContainer(
                  duration: 1.seconds,
                  curve: Curves.elasticOut,
                  height: 80 * heightFactor.clamp(0.08, 1.0),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        isToday ? AppTheme.secondary : AppTheme.primary,
                        isToday ? AppTheme.secondary.withOpacity(0.3) : AppTheme.primary.withOpacity(0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: isToday 
                        ? [BoxShadow(color: AppTheme.secondary.withOpacity(0.3), blurRadius: 10)]
                        : [],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  ['M', 'T', 'W', 'T', 'F', 'S', 'S'][date.weekday - 1],
                  style: GoogleFonts.outfit(
                    fontSize: 11, 
                    fontWeight: isToday ? FontWeight.w900 : FontWeight.w700, 
                    color: isToday ? AppTheme.secondary : AppTheme.textTertiary,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/haptic_service.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: 'Fuel Your\nMindset',
      desc: 'Curated psychology-driven insights to build daily mental resilience.',
      icon: Icons.auto_awesome_rounded,
      color: AppTheme.primary,
    ),
    OnboardingData(
      title: 'Unleash Your\nCreativity',
      desc: 'Design and share aesthetic quote cards with our premium Studio.',
      icon: Icons.palette_rounded,
      color: const Color(0xFFF59E0B),
    ),
    OnboardingData(
      title: 'Track Your\nEvolution',
      desc: 'Log reflections and watch your mindset grow on a professional dashboard.',
      icon: Icons.insights_rounded,
      color: const Color(0xFF10B981),
    ),
    OnboardingData(
      title: 'Privacy & Control',
      desc: 'Your data is encrypted and stays yours. Permanent account deletion is one tap away.',
      icon: Icons.security_rounded,
      color: const Color(0xFF6C63FF),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          // Dynamic Background Gradient
          AnimatedContainer(
            duration: 800.ms,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _pages[_currentPage].color.withOpacity(0.15),
                  AppTheme.background,
                ],
              ),
            ),
          ),
          
          PageView.builder(
            controller: _pageController,
            onPageChanged: (idx) {
              HapticService.selection();
              setState(() => _currentPage = idx);
            },
            itemCount: _pages.length,
            itemBuilder: (context, idx) => _buildPage(_pages[idx]),
          ),

          // Bottom Controls
          Positioned(
            bottom: 60,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Indicators
                Row(
                  children: List.generate(
                    _pages.length,
                    (idx) => AnimatedContainer(
                      duration: 300.ms,
                      margin: const EdgeInsets.only(right: 8),
                      height: 8,
                      width: _currentPage == idx ? 24 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == idx ? _pages[_currentPage].color : AppTheme.textTertiary.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),

                // Button
                _currentPage == _pages.length - 1
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _pages[_currentPage].color,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: () {
                          HapticService.success();
                          _finishOnboarding();
                        },
                        child: Text(
                          'Let\'s Go',
                          style: GoogleFonts.outfit(fontWeight: FontWeight.w800, color: Colors.white),
                        ),
                      ).animate().scale().fadeIn()
                    : IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: _pages[_currentPage].color,
                          fixedSize: const Size(56, 56),
                        ),
                        onPressed: () {
                          HapticService.light();
                          _pageController.nextPage(duration: 500.ms, curve: Curves.easeInOut);
                        },
                        icon: const Icon(Icons.arrow_forward_rounded, color: Colors.white),
                      ),
              ],
            ),
          ),

          // Skip button
          Positioned(
            top: 60,
            right: 24,
            child: TextButton(
              onPressed: () {
                HapticService.medium();
                _finishOnboarding();
              },
              child: Text(
                'Skip',
                style: GoogleFonts.outfit(
                  color: AppTheme.textTertiary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingData data) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: data.color.withOpacity(0.2),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Icon(data.icon, size: 80, color: data.color),
          ).animate(key: ValueKey(data.title)).scale(duration: 600.ms).rotate(begin: 0.1),
          const SizedBox(height: 60),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 42,
              fontWeight: FontWeight.w900,
              height: 1.1,
              color: AppTheme.textPrimary,
              letterSpacing: -1,
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              data.desc,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 16,
                color: AppTheme.textSecondary,
                height: 1.5,
              ),
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
        ],
      ),
    );
  }

  Future<void> _finishOnboarding() async {
    await LocalStorageService.setOnboardingDone(true);
    if (mounted) {
      context.go('/home');
    }
  }
}

class OnboardingData {
  final String title;
  final String desc;
  final IconData icon;
  final Color color;

  OnboardingData({
    required this.title,
    required this.desc,
    required this.icon,
    required this.color,
  });
}

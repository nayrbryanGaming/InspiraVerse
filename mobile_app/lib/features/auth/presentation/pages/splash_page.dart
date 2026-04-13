import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/services/local_storage_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        if (!LocalStorageService.isOnboardingDone) {
          context.go('/onboarding');
        } else {
          // Assume user is checking auth state here natively or via riverpod
          // For now let's just go straight to home
          context.go('/home');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: Stack(
        children: [
          // Dynamic immersive background
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    AppTheme.primaryDark,
                    AppTheme.darkBackground,
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.network(
                'https://www.transparenttextures.com/patterns/cubes.png',
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Spark Logo
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.05),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primary.withOpacity(0.3),
                        blurRadius: 50,
                        spreadRadius: 10,
                      )
                    ],
                  ),
                  child: const Icon(
                    Icons.auto_awesome_rounded,
                    size: 80,
                    color: Colors.white,
                  ),
                )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .scale(begin: const Offset(0.9, 0.9), end: const Offset(1.1, 1.1), duration: 2000.ms, curve: Curves.easeInOut)
                    .shimmer(duration: 2000.ms),
                const SizedBox(height: 32),
                Text(
                  AppConstants.appName.toUpperCase(),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Colors.white,
                        letterSpacing: 4,
                        fontWeight: FontWeight.w900,
                      ),
                ).animate().fadeIn(delay: 400.ms, duration: 800.ms).slideY(begin: 0.2),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'ELEVATE YOUR MINDSET',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.secondary,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ).animate().fadeIn(delay: 800.ms, duration: 800.ms).scale(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

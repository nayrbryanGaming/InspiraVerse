import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/app_theme.dart';
import '../core/services/haptic_service.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final currentIndex = _calculateSelectedIndex(context);

    return Scaffold(
      extendBody: true, // Crucial for Glassmorphism overlap
      body: child,
      bottomNavigationBar: Container(
        height: 90,
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(context, 0, Icons.home_rounded, 'Home', currentIndex),
                  _buildNavItem(context, 1, Icons.palette_rounded, 'Design', currentIndex),
                  _buildNavItem(context, 2, Icons.auto_awesome_rounded, 'Journey', currentIndex),
                  _buildNavItem(context, 3, Icons.person_rounded, 'Profile', currentIndex),
                ],
              ),
            ),
          ),
        ),
      ).animate().slideY(begin: 1.0, duration: 800.ms, curve: Curves.easeOutCirc),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, String label, int currentIndex) {
    final isSelected = currentIndex == index;
    final color = isSelected ? AppTheme.primary : AppTheme.textTertiary.withOpacity(0.5);

    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          HapticService.light();
          _onItemTapped(index, context);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Colors.transparent, // Expand tap area
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: isSelected ? 28 : 24,
            ).animate(target: isSelected ? 1 : 0).scale(duration: 200.ms),
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppTheme.primary,
                  shape: BoxShape.circle,
                ),
              ).animate().scale().fadeIn(),
          ],
        ),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/designer')) return 1;
    if (location.startsWith('/journey')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0: context.go('/home'); break;
      case 1: context.go('/designer'); break;
      case 2: context.go('/journey'); break;
      case 3: context.go('/profile'); break;
    }
  }
}

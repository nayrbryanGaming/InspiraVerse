import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/haptic_service.dart';

class ZenBreathingPortal extends StatefulWidget {
  const ZenBreathingPortal({super.key});

  @override
  State<ZenBreathingPortal> createState() => _ZenBreathingPortalState();
}

class _ZenBreathingPortalState extends State<ZenBreathingPortal> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _phase = 'Prepare';
  int _secondsLeft = 0;
  Timer? _timer;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
  }

  void _toggleBreathing() {
    if (_isActive) {
      _stopBreathing();
    } else {
      _startBreathing();
    }
  }

  void _startBreathing() async {
    setState(() {
      _isActive = true;
      _phase = 'Inhale';
    });
    _runCycle();
  }

  void _stopBreathing() {
    _timer?.cancel();
    _controller.stop();
    setState(() {
      _isActive = false;
      _phase = 'Rest';
      _secondsLeft = 0;
    });
    HapticService.light();
  }

  void _runCycle() async {
    while (_isActive && mounted) {
      // Inhale: 4s
      await _executePhase('Inhale', 4, true);
      if (!_isActive) break;

      // Hold: 7s
      await _executePhase('Hold', 7, null);
      if (!_isActive) break;

      // Exhale: 8s
      await _executePhase('Exhale', 8, false);
    }
  }

  Future<void> _executePhase(String name, int seconds, bool? expand) async {
    if (!mounted) return;
    setState(() {
      _phase = name;
      _secondsLeft = seconds;
    });

    if (expand == true) {
      _controller.duration = Duration(seconds: seconds);
      _controller.forward();
      HapticService.light();
    } else if (expand == false) {
      _controller.duration = Duration(seconds: seconds);
      _controller.reverse();
      HapticService.medium();
    } else {
      HapticService.selection();
    }

    // Countdown Timer logic
    final completer = Completer<void>();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || !_isActive) {
        timer.cancel();
        if (!completer.isCompleted) completer.complete();
        return;
      }
      setState(() {
        if (_secondsLeft > 1) {
          _secondsLeft--;
          if (name == 'Hold') HapticService.selection();
        } else {
          timer.cancel();
          completer.complete();
        }
      });
    });

    return completer.future;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: 600.ms,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: _isActive ? AppTheme.primaryExtraLight : Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.08),
            blurRadius: 40,
            offset: const Offset(0, 16),
          ),
        ],
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
                    'ZEN PORTAL',
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.primary,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    'Mindful Breath Control',
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textTertiary,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: _toggleBreathing,
                icon: Icon(
                  _isActive ? Icons.stop_circle_rounded : Icons.play_circle_filled_rounded,
                  color: AppTheme.primary,
                  size: 40,
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          Stack(
            alignment: Alignment.center,
            children: [
              // Rotating Outer Ring (Ambient)
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.primary.withOpacity(0.1),
                    width: 2,
                  ),
                ),
              ).animate(onPlay: (c) => c.repeat()).rotate(duration: 15.seconds),
              
              // Animated Pulse Circle
              ScaleTransition(
                scale: Tween<double>(begin: 0.7, end: 1.3).animate(
                  CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
                ),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppTheme.zenGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primary.withOpacity(0.4),
                        blurRadius: 40,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
              
              // Glass Interior UI
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _phase.toUpperCase(),
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                          letterSpacing: 1,
                        ),
                      ),
                      if (_isActive)
                        Text(
                          '$_secondsLeft',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 28,
                          ),
                        ).animate(key: ValueKey(_secondsLeft)).scale(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          Text(
            _isActive 
                ? 'Follow the rhythm. Release tension.'
                : 'Tap play to begin 4-7-8 session.',
            style: GoogleFonts.outfit(
              fontSize: 15,
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ).animate(key: ValueKey(_isActive)).fadeIn(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMethodBadge('In 4'),
              _buildMethodBadge('Hold 7'),
              _buildMethodBadge('Out 8'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMethodBadge(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: GoogleFonts.outfit(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: AppTheme.textTertiary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

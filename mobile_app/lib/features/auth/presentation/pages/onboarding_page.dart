import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/services/local_storage_service.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Icon(
                Icons.self_improvement,
                size: 120,
                color: Color(0xFF6C63FF),
              ),
              const SizedBox(height: 48),
              Text(
                'Find your daily inspiration.',
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Personalized quotes delivered to you every day to keep your mindset strong and clear.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  await LocalStorageService.setOnboardingDone(true);
                  if (context.mounted) {
                    context.go('/home');
                  }
                },
                child: const Text('Get Started'),
              ),
              TextButton(
                onPressed: () {
                  context.push('/login');
                },
                child: const Text('Log In'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/quotes/presentation/pages/quote_detail_page.dart';
import '../../features/quotes/presentation/pages/category_quotes_page.dart';
import '../../features/favorites/presentation/pages/favorites_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/privacy_hub_page.dart';
import '../../features/share/presentation/pages/share_card_page.dart';
import '../../features/designer/presentation/pages/quote_designer_screen.dart';
import '../../features/journey/presentation/pages/growth_dashboard.dart';
import '../../widgets/main_scaffold.dart';

import '../services/local_storage_service.dart';
import 'auth_notifier.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authNotifier = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final isAuthenticated = authNotifier.isAuthenticated;
      final isOnboardingDone = LocalStorageService.isOnboardingDone;
      
      final isSplash = state.matchedLocation == '/splash';
      final isLoggingIn = state.matchedLocation == '/login';
      final isOnboarding = state.matchedLocation == '/onboarding';

      // 1. Splash Page Logic: Wait for it to finish and then decide
      if (isSplash) return null;

      // 2. Onboarding Logic
      if (!isOnboardingDone) {
        if (isOnboarding) return null;
        return '/onboarding';
      }

      // 3. Auth Logic
      if (!isAuthenticated) {
        if (isLoggingIn || isOnboarding) return null;
        return '/login';
      }

      // 4. Authenticated users shouldn't see Login or Onboarding
      if (isLoggingIn || isOnboarding) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/favorites',
            name: 'favorites',
            builder: (context, state) => const FavoritesPage(),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const ProfilePage(),
          ),
          GoRoute(
            path: '/designer',
            name: 'designer',
            builder: (context, state) => const QuoteDesignerScreen(),
          ),
          GoRoute(
            path: '/journey',
            name: 'journey',
            builder: (context, state) => const GrowthDashboard(),
          ),
          GoRoute(
            path: '/privacy-hub',
            name: 'privacy-hub',
            builder: (context, state) => const PrivacyHubPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/quote/:quoteId',
        name: 'quote-detail',
        builder: (context, state) => QuoteDetailPage(
          quoteId: state.pathParameters['quoteId']!,
        ),
      ),
      GoRoute(
        path: '/category/:category',
        name: 'category-quotes',
        builder: (context, state) => CategoryQuotesPage(
          category: state.pathParameters['category']!,
        ),
      ),
      GoRoute(
        path: '/share/:quoteId',
        name: 'share-card',
        builder: (context, state) => ShareCardPage(
          quoteId: state.pathParameters['quoteId']!,
        ),
      ),
    ],
  );
});

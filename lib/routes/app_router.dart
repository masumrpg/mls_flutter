import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';
import '../features/auth/ui/pages/auth_page.dart';
import '../features/auth/ui/pages/auth_login_page.dart';
import '../features/splash/ui/pages/splash_page.dart';
import '../features/onboarding/ui/pages/onboarding_page.dart';
import '../features/dashboard/ui/pages/dashboard_page.dart';
import '../features/quran/ui/pages/quran_page.dart';
import '../features/quran/ui/pages/quran_surah_detail_page.dart';
import '../features/sholat/ui/pages/sholat_page.dart';
import '../features/hadis/ui/pages/hadis_page.dart';
import '../features/hadis/ui/pages/hadis_search_page.dart';
import '../features/hadis/ui/pages/hadis_detail_page.dart';
import '../features/kalender/ui/pages/kalender_page.dart';
import '../features/profil/ui/pages/profil_page.dart';
import '../features/qibla/ui/pages/qibla_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: RouteNames.splash,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RouteNames.home,
        name: RouteNames.home,
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: RouteNames.auth,
        name: RouteNames.auth,
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: RouteNames.authLogin,
        name: RouteNames.authLogin,
        builder: (context, state) => const AuthLoginPage(),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        name: RouteNames.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: RouteNames.dashboard,
        name: RouteNames.dashboard,
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: RouteNames.quran,
        name: RouteNames.quran,
        builder: (context, state) => const QuranPage(),
        routes: [
          GoRoute(
            path: 'detail/:id',
            name: 'surah_detail',
            builder: (context, state) {
              final id = int.tryParse(state.pathParameters['id'] ?? '1') ?? 1;
              final ayah = int.tryParse(
                state.uri.queryParameters['ayah'] ?? '',
              );
              return QuranSurahDetailPage(surahNumber: id, initialAyah: ayah);
            },
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.sholat,
        name: RouteNames.sholat,
        builder: (context, state) => const SholatPage(),
      ),
      GoRoute(
        path: RouteNames.hadis,
        name: RouteNames.hadis,
        builder: (context, state) => const HadisPage(),
      ),
      GoRoute(
        path: RouteNames.hadisSearch,
        name: RouteNames.hadisSearch,
        builder: (context, state) => const HadisSearchPage(),
      ),
      GoRoute(
        path: '${RouteNames.hadisDetail}/:id',
        name: RouteNames.hadisDetail,
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '1') ?? 1;
          return HadisDetailPage(hadisId: id);
        },
      ),
      GoRoute(
        path: RouteNames.kalender,
        name: RouteNames.kalender,
        builder: (context, state) => const KalenderPage(),
      ),
      GoRoute(
        path: RouteNames.profil,
        name: RouteNames.profil,
        builder: (context, state) => const ProfilPage(),
      ),
          GoRoute(
        path: RouteNames.qibla,
        name: RouteNames.qibla,
        builder: (context, state) => const QiblaPage(),
      ),
],

    // Error handling
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    ),
  );
}

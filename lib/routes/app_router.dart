import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';
import '../features/home/ui/pages/home_page.dart';
import '../features/auth/ui/pages/auth_page.dart';
import '../features/auth/ui/pages/auth_login_page.dart';
import '../features/splash/ui/pages/splash_page.dart';
import '../features/onboarding/ui/pages/onboarding_page.dart';
import '../features/dashboard/ui/pages/dashboard_page.dart';
import '../features/quran/ui/pages/quran_page.dart';
import '../features/sholat/ui/pages/sholat_page.dart';
import '../features/hadis/ui/pages/hadis_page.dart';
import '../features/kalender/ui/pages/kalender_page.dart';
import '../features/profile/ui/pages/profile_page.dart';
import '../features/quran/ui/pages/quran_quran_home_page.dart';
import '../features/quran/ui/pages/quran_surah_detail_page.dart';
import '../features/sholat/ui/pages/sholat_sholat_home_page.dart';
import '../features/hadis/ui/pages/hadis_hadis_home_page.dart';
import '../features/kalender/ui/pages/kalender_kalender_home_page.dart';
import '../features/profile/ui/pages/profile_profile_home_page.dart';
import '../features/qibla/ui/pages/qibla_page.dart';
import '../features/qibla/ui/pages/qibla_qibla_home_page.dart';
import '../features/profil/ui/pages/profil_page.dart';

class AppRouter {
  static final _isDesktop =
      Platform.isLinux || Platform.isWindows || Platform.isMacOS;

  static final router = GoRouter(
    initialLocation: _isDesktop ? RouteNames.splash : RouteNames.home,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RouteNames.home,
        name: RouteNames.home,
        builder: (context, state) => const HomePage(),
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
              return QuranSurahDetailPage(surahNumber: id);
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
        path: RouteNames.kalender,
        name: RouteNames.kalender,
        builder: (context, state) => const KalenderPage(),
      ),
      GoRoute(
        path: RouteNames.profile,
        name: RouteNames.profile,
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: RouteNames.quranQuranHome,
        name: RouteNames.quranQuranHome,
        builder: (context, state) => const QuranQuranHomePage(),
      ),
      GoRoute(
        path: RouteNames.sholatSholatHome,
        name: RouteNames.sholatSholatHome,
        builder: (context, state) => const SholatSholatHomePage(),
      ),
      GoRoute(
        path: RouteNames.hadisHadisHome,
        name: RouteNames.hadisHadisHome,
        builder: (context, state) => const HadisHadisHomePage(),
      ),
      GoRoute(
        path: RouteNames.kalenderKalenderHome,
        name: RouteNames.kalenderKalenderHome,
        builder: (context, state) => const KalenderKalenderHomePage(),
      ),
      GoRoute(
        path: RouteNames.profileProfileHome,
        name: RouteNames.profileProfileHome,
        builder: (context, state) => const ProfileProfileHomePage(),
      ),
      GoRoute(
        path: RouteNames.qibla,
        name: RouteNames.qibla,
        builder: (context, state) => const QiblaPage(),
      ),
      GoRoute(
        path: RouteNames.qiblaQiblaHome,
        name: RouteNames.qiblaQiblaHome,
        builder: (context, state) => const QiblaQiblaHomePage(),
      ),
      GoRoute(
        path: RouteNames.profil,
        name: RouteNames.profil,
        builder: (context, state) => const ProfilPage(),
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

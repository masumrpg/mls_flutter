import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../routes/route_names.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // Jalankan setelah frame pertama untuk menghindari race dengan context
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          context.goNamed(RouteNames.onboarding);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final td = Theme.of(context);
    final cs = td.colorScheme;
    final textTheme = td.textTheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              turns: const AlwaysStoppedAnimation(3/360),
              child: Container(
                decoration: BoxDecoration(
                  color: cs.onPrimary,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/logo_no_bg.png',
                  width: 150,
                  height: 150,
                  color: cs.primary,
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
            ),

            const SizedBox(height: 32),

            Text(
              'Moslem Life Style',
              style: textTheme.headlineLarge?.copyWith(
                color: cs.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
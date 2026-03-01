import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/app_loading_bar.dart';
import '../../../../../routes/route_names.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _controller.addListener(() {
      if (_controller.isCompleted && mounted) {
        context.goNamed(RouteNames.onboarding);
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final td = Theme.of(context);
    final cs = td.colorScheme;
    final textTheme = td.textTheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Stack(
          children: [
            // Main content centered
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotationTransition(
                      turns: const AlwaysStoppedAnimation(3 / 360),
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
                        color: cs.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'My Digital Learning Islam',
                      style: textTheme.headlineLarge?.copyWith(
                        color: cs.onSurface,
                        letterSpacing: 2,
                        fontSize: 16,
                        fontWeight: FontWeight.w100,
                      ),
                    ),

                    const SizedBox(height: 64),

                    // Loading bar
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return AppLoadingBar(
                          value: _controller.value,
                          color: cs.primary,
                          backgroundColor: cs.primary.withValues(alpha: 0.15),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Version text at bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  'VERSION 0.0.1',
                  style: textTheme.labelMedium?.copyWith(
                    color: cs.onSurface.withValues(alpha: 0.4),
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
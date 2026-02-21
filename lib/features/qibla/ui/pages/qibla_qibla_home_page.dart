import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../bloc/qibla_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import 'dart:math' as math;

class QiblaQiblaHomePage extends StatelessWidget {
  const QiblaQiblaHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<QiblaBloc>()..add(const FetchQibla(latitude: -6.200000, longitude: 106.816666)),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Arah Kiblat',
            style: AppTypography.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<QiblaBloc, QiblaState>(
          builder: (context, state) {
            if (state is QiblaLoading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            } else if (state is QiblaError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: AppTypography.textTheme.bodyLarge?.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<QiblaBloc>().add(const FetchQibla(latitude: -6.200000, longitude: 106.816666));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (state is QiblaLoaded) {
              final qibla = state.qibla;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 280,
                      height: 280,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 2),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Compass rose or decorative circle
                          Container(
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF1E293B),
                              border: Border.all(color: Colors.white10, width: 1),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(padding: EdgeInsets.all(8.0), child: Text('N', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))),
                                Padding(padding: EdgeInsets.all(8.0), child: Text('S', style: TextStyle(color: Colors.white54))),
                              ],
                            ),
                          ),
                          // Arrow pointing to Qibla
                          Transform.rotate(
                            angle: qibla.direction * (math.pi / 180),
                            child: const Icon(
                              Icons.navigation,
                              size: 80,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),
                    Text(
                      '${qibla.direction.toStringAsFixed(2)}°',
                      style: AppTypography.textTheme.displayMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Dari Utara Sejati',
                      style: AppTypography.textTheme.bodyLarge?.copyWith(color: Colors.white54),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

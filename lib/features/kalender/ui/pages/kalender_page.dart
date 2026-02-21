import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../bloc/kalender_bloc.dart';
import '../../bloc/kalender_event.dart';
import '../../bloc/kalender_state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class KalenderPage extends StatelessWidget {
  const KalenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<KalenderBloc>()..add(const FetchKalenderToday()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            'Kalender Islam',
            style: AppTypography.textTheme.headlineMedium?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.menu, color: AppColors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          backgroundColor: AppColors.primary,
          elevation: 0,
        ),
        body: SafeArea(
          child: BlocBuilder<KalenderBloc, KalenderState>(
            builder: (context, state) {
              if (state is KalenderLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              } else if (state is KalenderError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline,
                            size: 64, color: AppColors.error),
                        const SizedBox(height: 16),
                        Text(
                          'Gagal Memuat Kalender',
                          style: AppTypography.textTheme.titleLarge?.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.message,
                          style: AppTypography.textTheme.bodyMedium?.copyWith(
                            color: AppColors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            context.read<KalenderBloc>().add(const FetchKalenderToday());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                          child: const Text('Coba Lagi'),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state is KalenderLoaded) {
                final kalender = state.kalender;
                return ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    _buildDateCard(
                      title: 'Masehi',
                      dateLabel: kalender.ce.today,
                      dateNumber: kalender.ce.day.toString(),
                      monthYear: '${kalender.ce.monthName} ${kalender.ce.year}',
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 16),
                    _buildDateCard(
                      title: 'Hijriah',
                      dateLabel: kalender.hijr.today,
                      dateNumber: kalender.hijr.day.toString(),
                      monthYear: '${kalender.hijr.monthName} ${kalender.hijr.year}',
                      color: AppColors.secondary,
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDateCard({
    required String title,
    required String dateLabel,
    required String dateNumber,
    required String monthYear,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: AppTypography.textTheme.titleMedium?.copyWith(
              color: AppColors.white.withValues(alpha: 0.8),
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            dateNumber,
            style: AppTypography.textTheme.displayLarge?.copyWith(
              color: AppColors.white,
              fontSize: 80,
              fontWeight: FontWeight.bold,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            monthYear,
            style: AppTypography.textTheme.headlineMedium?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              dateLabel,
              style: AppTypography.textTheme.bodyMedium?.copyWith(
                color: AppColors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

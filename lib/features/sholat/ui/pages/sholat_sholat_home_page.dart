import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../bloc/sholat_schedule_bloc.dart';

class SholatSholatHomePage extends StatelessWidget {
  const SholatSholatHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SholatView();
  }
}

class SholatView extends StatelessWidget {
  const SholatView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // A dark minimal background
    final darkBg = isDark
        ? AppColors.darkBackground
        : theme.scaffoldBackgroundColor;
    final textColor = isDark ? AppColors.darkText : AppColors.black;
    final subTextColor = isDark ? AppColors.darkTextSecondary : AppColors.grey;
    final cardBg = isDark ? AppColors.darkSurface : AppColors.white;

    return Scaffold(
      backgroundColor: darkBg,
      body: SafeArea(
        child: BlocBuilder<SholatScheduleBloc, SholatScheduleState>(
          builder: (context, state) {
            if (state is SholatScheduleLoading ||
                state is SholatScheduleInitial) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            } else if (state is SholatScheduleError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: AppTypography.textTheme.bodyLarge?.copyWith(
                        color: textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<SholatScheduleBloc>().add(
                          const FetchSholatSchedule(),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (state is SholatScheduleLoaded) {
              final schedule = state.schedule;
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 32.0,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        Text(
                          'Jadwal Sholat',
                          style: TextStyle(
                            fontSize: 16,
                            color: subTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          schedule.cityName,
                          style: AppTypography.textTheme.headlineLarge
                              ?.copyWith(color: textColor, fontSize: 28),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          schedule.date,
                          style: AppTypography.textTheme.bodyLarge?.copyWith(
                            color: subTextColor,
                          ),
                        ),
                        const SizedBox(height: 40),
                        _buildTimeCard(
                          'Imsak',
                          schedule.imsak,
                          Icons.nights_stay_outlined,
                          cardBg,
                          textColor,
                        ),
                        _buildTimeCard(
                          'Subuh',
                          schedule.subuh,
                          Icons.wb_twilight_outlined,
                          cardBg,
                          textColor,
                        ),
                        _buildTimeCard(
                          'Terbit',
                          schedule.terbit,
                          Icons.brightness_5_outlined,
                          cardBg,
                          textColor,
                        ),
                        _buildTimeCard(
                          'Dhuha',
                          schedule.dhuha,
                          Icons.brightness_high_outlined,
                          cardBg,
                          textColor,
                        ),
                        _buildTimeCard(
                          'Dzuhur',
                          schedule.dzuhur,
                          Icons.wb_sunny_outlined,
                          cardBg,
                          textColor,
                        ),
                        _buildTimeCard(
                          'Ashar',
                          schedule.ashar,
                          Icons.auto_awesome_outlined,
                          cardBg,
                          textColor,
                        ),
                        _buildTimeCard(
                          'Maghrib',
                          schedule.maghrib,
                          Icons.brightness_6_outlined,
                          cardBg,
                          textColor,
                        ),
                        _buildTimeCard(
                          'Isya',
                          schedule.isya,
                          Icons.dark_mode_outlined,
                          cardBg,
                          textColor,
                        ),
                      ]),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildTimeCard(
    String label,
    String time,
    IconData icon,
    Color cardBg,
    Color textColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: textColor.withValues(alpha: 0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 28),
              const SizedBox(width: 16),
              Text(
                label,
                style: AppTypography.textTheme.titleLarge?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Text(
            time,
            style: AppTypography.textTheme.headlineSmall?.copyWith(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../bloc/sholat_schedule_bloc.dart';

class SholatSholatHomePage extends StatelessWidget {
  const SholatSholatHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SholatScheduleBloc>()..add(const FetchSholatSchedule()),
      child: const SholatView(),
    );
  }
}

class SholatView extends StatelessWidget {
  const SholatView({super.key});

  @override
  Widget build(BuildContext context) {
    // A dark minimal background
    const darkBg = Color(0xFF0F172A);

    return Scaffold(
      backgroundColor: darkBg,
      body: SafeArea(
        child: BlocBuilder<SholatScheduleBloc, SholatScheduleState>(
          builder: (context, state) {
            if (state is SholatScheduleLoading || state is SholatScheduleInitial) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            } else if (state is SholatScheduleError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 48),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: AppTypography.textTheme.bodyLarge?.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<SholatScheduleBloc>().add(const FetchSholatSchedule());
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
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const Text(
                          'Jadwal Sholat',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          schedule.cityName,
                          style: AppTypography.textTheme.headlineLarge?.copyWith(color: Colors.white, fontSize: 28),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          schedule.date,
                          style: AppTypography.textTheme.bodyLarge?.copyWith(color: Colors.white54),
                        ),
                        const SizedBox(height: 40),
                        _buildTimeCard('Imsak', schedule.imsak, Icons.nights_stay_outlined),
                        _buildTimeCard('Subuh', schedule.subuh, Icons.wb_twilight_outlined),
                        _buildTimeCard('Terbit', schedule.terbit, Icons.brightness_5_outlined),
                        _buildTimeCard('Dhuha', schedule.dhuha, Icons.brightness_high_outlined),
                        _buildTimeCard('Dzuhur', schedule.dzuhur, Icons.wb_sunny_outlined),
                        _buildTimeCard('Ashar', schedule.ashar, Icons.auto_awesome_outlined),
                        _buildTimeCard('Maghrib', schedule.maghrib, Icons.brightness_6_outlined),
                        _buildTimeCard('Isya', schedule.isya, Icons.dark_mode_outlined),
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

  Widget _buildTimeCard(String label, String time, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
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
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Text(
            time,
            style: AppTypography.textTheme.headlineSmall?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

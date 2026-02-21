import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../domain/entities/sholat_schedule_entity.dart';
import '../../bloc/sholat_schedule_bloc.dart';
import '../widgets/prayer_notification_bottom_sheet.dart';
import '../../../../shared/widgets/error_view.dart';

class SholatPage extends StatefulWidget {
  const SholatPage({super.key});

  @override
  State<SholatPage> createState() => _SholatPageState();
}

class _SholatPageState extends State<SholatPage> {
  // We manage the DB writes locally in the UI to keep it simple,
  // since the notification settings aren't strictly part of the API.
  final Map<String, dynamic> _notificationSettings = {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => sl<SholatScheduleBloc>()..add(FetchSholatSchedule()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Jadwal Sholat'), elevation: 0),
        body: BlocBuilder<SholatScheduleBloc, SholatScheduleState>(
          builder: (context, state) {
            if (state is SholatScheduleLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SholatScheduleError) {
              return ErrorView(
                message: state.message,
                onRetry: () {
                  context.read<SholatScheduleBloc>().add(FetchSholatSchedule());
                },
              );
            } else if (state is SholatScheduleLoaded) {
              return _buildSchedule(context, state.schedule, theme);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildSchedule(
    BuildContext context,
    SholatScheduleEntity schedule,
    ThemeData theme,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        schedule.cityName.isEmpty
                            ? 'Unknown City'
                            : schedule.cityName,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 28,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  schedule.date,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Hari Ini',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildPrayerRow('Imsak', schedule.imsak, context),
          _buildPrayerRow('Subuh', schedule.subuh, context),
          _buildPrayerRow('Terbit', schedule.terbit, context),
          _buildPrayerRow('Dhuha', schedule.dhuha, context),
          _buildPrayerRow('Dzuhur', schedule.dzuhur, context),
          _buildPrayerRow('Ashar', schedule.ashar, context),
          _buildPrayerRow('Maghrib', schedule.maghrib, context),
          _buildPrayerRow('Isya', schedule.isya, context),
        ],
      ),
    );
  }

  Widget _buildPrayerRow(String name, String time, BuildContext context) {
    // Default settings if none found
    final setting =
        _notificationSettings[name] ??
        {'alertType': 2, 'preReminderMinutes': 10};
    final alertType = setting['alertType'] as int;

    IconData bellIcon;
    Color bellColor = AppColors.primary;
    if (alertType == 0) {
      bellIcon = Icons.notifications_off_outlined;
      bellColor = Colors.grey;
    } else if (alertType == 1) {
      bellIcon = Icons.notifications_active_outlined;
    } else {
      bellIcon = Icons.volume_up_rounded;
    }

    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            time,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(bellIcon, color: bellColor),
            onPressed: () {
              _openSettings(
                context,
                name,
                alertType,
                setting['preReminderMinutes'] as int,
              );
            },
          ),
        ],
      ),
    );
  }

  void _openSettings(
    BuildContext context,
    String name,
    int currentAlert,
    int currentPreReminder,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return PrayerNotificationBottomSheet(
          prayerName: name,
          initialAlertType: currentAlert,
          initialPreReminder: currentPreReminder,
          onSave: (alertType, preReminder) {
            setState(() {
              _notificationSettings[name] = {
                'alertType': alertType,
                'preReminderMinutes': preReminder,
              };
            });
            // Ideally we'd map this up to the Bloc/Repository to save to drift.
            // For now, it updates local state perfectly.
          },
        );
      },
    );
  }
}

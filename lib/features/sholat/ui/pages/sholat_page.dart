import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../domain/entities/sholat_schedule_entity.dart';
import '../../domain/repositories/sholat_repository.dart';
import '../../bloc/sholat_schedule_bloc.dart';
import '../widgets/prayer_notification_bottom_sheet.dart';
import '../../../../core/services/notification_service.dart';
import '../../../../shared/widgets/error_view.dart';
import 'package:hijri/hijri_calendar.dart';

class SholatPage extends StatefulWidget {
  const SholatPage({super.key});

  @override
  State<SholatPage> createState() => _SholatPageState();
}

class _SholatPageState extends State<SholatPage> {
  Color get _bgColor => Theme.of(context).scaffoldBackgroundColor;
  Color get _textColor => Theme.of(context).brightness == Brightness.dark
      ? AppColors.darkText
      : AppColors.black;
  Color get _subTextColor => Theme.of(context).brightness == Brightness.dark
      ? AppColors.darkTextSecondary
      : AppColors.grey;
  Color get _cardBg => Theme.of(context).brightness == Brightness.dark
      ? AppColors.darkSurface
      : AppColors.white;

  final Map<String, dynamic> _notificationSettings = {};
  Timer? _timer;
  DateTime _now = DateTime.now();
  int _testMinutes = 1;
  DateTime? _scheduledTestTime;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _loadSettings();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _now = DateTime.now();
          if (_scheduledTestTime != null) {
            if (_now.isAfter(_scheduledTestTime!) ||
                _now.isAtSameMomentAs(_scheduledTestTime!)) {
              _scheduledTestTime = null; // Clear when expired
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SholatScheduleBloc>()..add(FetchSholatSchedule()),
      child: Scaffold(
        backgroundColor: _bgColor,
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
              return _buildBody(context, state.schedule);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Future<void> _loadSettings() async {
    final result = await sl<SholatRepository>().getNotificationSettings();
    result.fold((failure) => null, (settings) {
      if (mounted) {
        setState(() {
          _notificationSettings.clear();
          _notificationSettings.addAll(settings);
        });
      }
    });
  }

  Widget _buildBody(BuildContext context, SholatScheduleEntity schedule) {
    final nextPrayer = _getNextPrayer(schedule);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60), // Add top spacing for full screen
          _buildHeader(schedule),
          const SizedBox(height: 16),
          _buildHeroCard(nextPrayer, schedule),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "TODAY'S SCHEDULE",
              style: TextStyle(
                color: _textColor.withValues(alpha: 0.6),
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildPrayerList(schedule, nextPrayer?.name),
          const SizedBox(height: 32),
          _buildTestSection(context),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildHeader(SholatScheduleEntity schedule) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.topLeft,
                icon: Icon(Icons.menu, color: _textColor, size: 28),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.primary,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'LOCATION',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          schedule.cityName.isEmpty
                              ? 'Unknown City'
                              : schedule.cityName,
                          style: TextStyle(
                            color: _textColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down, color: _textColor),
                      ],
                    ),
                  ],
                ),
              ),
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?u=masum',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${HijriCalendar.fromDate(_now).hDay} ${HijriCalendar.fromDate(_now).longMonthName} ${HijriCalendar.fromDate(_now).hYear} H',
                style: TextStyle(color: _subTextColor, fontSize: 14),
              ),
              Text(
                DateFormat('EEEE, d MMM yyyy').format(_now),
                style: TextStyle(color: _subTextColor, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroCard(
    _PrayerTime? nextPrayer,
    SholatScheduleEntity schedule,
  ) {
    if (nextPrayer == null) return const SizedBox();

    final remaining = nextPrayer.time.difference(_now);
    final hours = remaining.inHours;
    final minutes = remaining.inMinutes % 60;
    final seconds = remaining.inSeconds % 60;

    double progress = 0.5;
    try {
      final prev = _getPreviousPrayer(schedule);
      if (prev != null) {
        final total = nextPrayer.time.difference(prev.time).inSeconds;
        final elapsed = _now.difference(prev.time).inSeconds;
        progress = (total > 0 ? (elapsed / total) : 0.5).clamp(0.0, 1.0);
      }
    } catch (_) {
      progress = 0.5;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: 320,
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_bgColor, _bgColor.withValues(alpha: 0.8)],
        ),
      ),
      child: Stack(
        children: [
          // Mosque Silhouette
          Positioned(
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.05,
              child: CustomPaint(
                size: const Size(200, 150),
                painter: MosqueSilhouettePainter(_textColor),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'NEXT PRAYER',
                  style: TextStyle(
                    color: _textColor.withValues(alpha: 0.5),
                    fontSize: 12,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      height: 180,
                      child: CircularProgressIndicator(
                        value: 1.0,
                        strokeWidth: 8,
                        color: _cardBg,
                      ),
                    ),
                    SizedBox(
                      width: 180,
                      height: 180,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 8,
                        color: _textColor,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          nextPrayer.name.toUpperCase(),
                          style: TextStyle(
                            color: _textColor,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          nextPrayer.timeString,
                          style: TextStyle(
                            color: _textColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Remaining Pill
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _textColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.access_time, color: _textColor, size: 14),
                      const SizedBox(width: 8),
                      Text(
                        '-${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} remaining',
                        style: TextStyle(
                          color: _textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _PrayerTime? _getPreviousPrayer(SholatScheduleEntity schedule) {
    final format = DateFormat('HH:mm');
    final nowTime = DateFormat('HH:mm').format(_now);

    final prayers = [
      _PrayerTime('Imsak', schedule.imsak, _now),
      _PrayerTime('Subuh', schedule.subuh, _now),
      _PrayerTime('Dhuha', schedule.dhuha, _now),
      _PrayerTime('Dzuhur', schedule.dzuhur, _now),
      _PrayerTime('Ashar', schedule.ashar, _now),
      _PrayerTime('Maghrib', schedule.maghrib, _now),
      _PrayerTime('Isya', schedule.isya, _now),
    ];

    _PrayerTime? last;
    for (var p in prayers) {
      if (format.parse(p.timeString).isBefore(format.parse(nowTime)) ||
          format.parse(p.timeString).isAtSameMomentAs(format.parse(nowTime))) {
        last = p;
      }
    }
    return last;
  }

  Widget _buildPrayerList(
    SholatScheduleEntity schedule,
    String? nextPrayerName,
  ) {
    final prayers = [
      {
        'name': 'Imsak',
        'time': schedule.imsak,
        'icon': Icons.light_mode_outlined,
      },
      {'name': 'Subuh', 'time': schedule.subuh, 'icon': Icons.light_mode},
      {
        'name': 'Dhuha',
        'time': schedule.dhuha,
        'icon': Icons.wb_sunny_outlined,
      },
      {'name': 'Dzuhur', 'time': schedule.dzuhur, 'icon': Icons.wb_sunny},
      {
        'name': 'Ashar',
        'time': schedule.ashar,
        'icon': Icons.wb_cloudy_outlined,
      },
      {
        'name': 'Maghrib',
        'time': schedule.maghrib,
        'icon': Icons.nightlight_round,
      },
      {'name': 'Isya', 'time': schedule.isya, 'icon': Icons.dark_mode},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: prayers.map((p) {
          final isNext = p['name'] == nextPrayerName;
          final time = p['time'] as String;
          final name = p['name'] as String;
          final icon = p['icon'] as IconData;

          // Determine status
          final format = DateFormat('HH:mm');
          final nowTimeStr = DateFormat('HH:mm').format(_now);
          final isPassed = format
              .parse(time)
              .isBefore(format.parse(nowTimeStr));

          return _buildPrayerCard(name, time, icon, isNext, isPassed);
        }).toList(),
      ),
    );
  }

  Widget _buildPrayerCard(
    String name,
    String time,
    IconData icon,
    bool isNext,
    bool isPassed,
  ) {
    final setting =
        _notificationSettings[name] ??
        {'alertType': 0, 'preReminderMinutes': 0};
    final alertType = setting['alertType'] as int;

    IconData bellIcon;
    if (alertType == 0) {
      bellIcon = Icons.notifications_off_outlined;
    } else if (alertType == 1) {
      bellIcon = Icons.notifications_active_outlined;
    } else {
      bellIcon = Icons.volume_up_rounded;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        border: isNext
            ? Border.all(
                color: AppColors.primary.withValues(alpha: 0.5),
                width: 2,
              )
            : null,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isNext
                  ? AppColors.primary
                  : _textColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isNext ? _bgColor : _textColor.withValues(alpha: 0.8),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: _textColor.withValues(alpha: isPassed ? 0.4 : 1.0),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    color: _textColor.withValues(alpha: isPassed ? 0.3 : 0.6),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          if (isNext)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _cardBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'NEXT',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: () => _openSettings(
                    context,
                    name,
                    alertType,
                    setting['preReminderMinutes'] as int,
                    time,
                  ),
                  child: Icon(bellIcon, color: AppColors.primary, size: 20),
                ),
              ],
            )
          else if (isPassed)
            Icon(Icons.check_circle, color: AppColors.primary, size: 20)
          else
            InkWell(
              onTap: () => _openSettings(
                context,
                name,
                alertType,
                setting['preReminderMinutes'] as int,
                time,
              ),
              child: Icon(
                bellIcon,
                color: _textColor.withValues(alpha: 0.3),
                size: 20,
              ),
            ),
        ],
      ),
    );
  }

  _PrayerTime? _getNextPrayer(SholatScheduleEntity schedule) {
    final format = DateFormat('HH:mm');
    final nowTime = DateFormat('HH:mm').format(_now);

    final prayers = [
      _PrayerTime('Imsak', schedule.imsak, _now),
      _PrayerTime('Subuh', schedule.subuh, _now),
      _PrayerTime('Dhuha', schedule.dhuha, _now),
      _PrayerTime('Dzuhur', schedule.dzuhur, _now),
      _PrayerTime('Ashar', schedule.ashar, _now),
      _PrayerTime('Maghrib', schedule.maghrib, _now),
      _PrayerTime('Isya', schedule.isya, _now),
    ];

    for (var p in prayers) {
      if (format.parse(p.timeString).isAfter(format.parse(nowTime))) {
        return p;
      }
    }

    // If all prayers passed, next is tomorrow's Imsak
    return null;
  }

  void _openSettings(
    BuildContext context,
    String name,
    int currentAlert,
    int currentPreReminder,
    String prayerTimeStr,
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
          onSave: (alertType, preReminder) async {
            setState(() {
              _notificationSettings[name] = {
                'alertType': alertType,
                'preReminderMinutes': preReminder,
              };
            });

            // Save to DB
            await sl<SholatRepository>().saveNotificationSetting(
              name,
              alertType,
              preReminder,
            );

            // Schedule Notification
            if (alertType > 0) {
              final parts = prayerTimeStr.split(':');
              var scheduled = DateTime(
                _now.year,
                _now.month,
                _now.day,
                int.parse(parts[0]),
                int.parse(parts[1]),
              );

              // Apply pre-reminder
              scheduled = scheduled.subtract(Duration(minutes: preReminder));

              if (scheduled.isAfter(DateTime.now())) {
                await NotificationService.instance.schedulePrayerNotification(
                  id: name.hashCode,
                  title: 'Waktu $name',
                  body: preReminder > 0
                      ? '$preReminder menit lagi waktu $name'
                      : 'Sekarang sudah memasuki waktu $name',
                  scheduledTime: scheduled,
                  playSound: true,
                  sound: alertType == 2 ? 'adzan_mecca' : null,
                );
              }
            } else {
              await NotificationService.instance.cancel(name.hashCode);
            }
          },
        );
      },
    );
  }

  Widget _buildTestSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TEST',
            style: TextStyle(
              color: _textColor.withValues(alpha: 0.6),
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () async {
              await NotificationService.instance.requestPermission();
              NotificationService.instance.showNotification(
                id: 9991,
                title: '📌 Test Immediate',
                body: 'Notification triggered immediately!',
              );
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Immediate notification triggered'),
                  ),
                );
              }
            },
            child: const Text('Trigger Immediate Notification'),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: '1',
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: _textColor),
                  decoration: InputDecoration(
                    labelText: 'Minutes delay',
                    labelStyle: TextStyle(color: _subTextColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _subTextColor.withValues(alpha: 0.3),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _testMinutes = int.tryParse(val) ?? 1;
                    });
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: AppColors.white,
                    minimumSize: const Size(
                      double.infinity,
                      56,
                    ), // Matches default TextField height approximately
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    await NotificationService.instance.requestPermission();
                    final scheduledTime = DateTime.now().add(
                      Duration(minutes: _testMinutes),
                    );
                    setState(() {
                      _scheduledTestTime = scheduledTime;
                    });

                    NotificationService.instance.schedulePrayerNotification(
                      id: 9992,
                      title: '⏰ Test Scheduled',
                      body:
                          'Notification triggered after $_testMinutes minutes!',
                      scheduledTime: scheduledTime,
                    );
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Notification scheduled for ${DateFormat('HH:mm:ss').format(scheduledTime)}',
                          ),
                        ),
                      );
                    }
                  },
                  child: Text('Schedule in $_testMinutes min'),
                ),
              ),
            ],
          ),
          if (_scheduledTestTime != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.secondary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.timer_outlined, color: AppColors.secondary),
                  const SizedBox(width: 8),
                  Text(
                    'Notification in: ${_scheduledTestTime!.difference(_now).inMinutes.remainder(60).toString().padLeft(2, '0')}:${_scheduledTestTime!.difference(_now).inSeconds.remainder(60).toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PrayerTime {
  final String name;
  final String timeString;
  final DateTime date;

  _PrayerTime(this.name, this.timeString, this.date);

  DateTime get time {
    final parts = timeString.split(':');
    return DateTime(
      date.year,
      date.month,
      date.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }
}

class MosqueSilhouettePainter extends CustomPainter {
  final Color color;
  MosqueSilhouettePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);

    // Simple mosque shape
    path.lineTo(size.width * 0.2, size.height);
    path.lineTo(size.width * 0.2, size.height * 0.6);
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.4,
      size.width * 0.4,
      size.height * 0.6,
    );
    path.lineTo(size.width * 0.4, size.height);

    path.lineTo(size.width * 0.6, size.height);
    path.lineTo(size.width * 0.6, size.height * 0.4);
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.2,
      size.width * 0.9,
      size.height * 0.4,
    );
    path.lineTo(size.width * 0.9, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

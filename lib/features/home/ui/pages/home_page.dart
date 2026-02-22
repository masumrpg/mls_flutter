import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../routes/route_names.dart';
import '../../../../core/di/service_locator.dart';
import '../../../sholat/domain/entities/sholat_schedule_entity.dart';
import '../../../sholat/bloc/sholat_schedule_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  Timer? _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _startTimer();
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
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              _buildHeader(),
              const SizedBox(height: 24),
              BlocBuilder<SholatScheduleBloc, SholatScheduleState>(
                builder: (context, state) {
                  if (state is SholatScheduleLoaded) {
                     return _buildStatusCard(state.schedule);
                  }
                  return const Center(child: CircularProgressIndicator());
                }
              ),
              const SizedBox(height: 16),
              _buildDateCards(),
              const SizedBox(height: 32),
              _buildMenuSection(),
              const SizedBox(height: 32),
              _buildQuoteSection(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Assalamu'alaikum",
                style: TextStyle(
                  color: _subTextColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _getGreeting(),
                style: TextStyle(
                  color: _textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const CircleAvatar(
             radius: 20,
             backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=ahmad'),
          ),
        ],
      ),
    );
  }

  String _getGreeting() {
    final hour = _now.hour;
    if (hour < 11) return 'Sabahul Khair, Ahmad';
    if (hour < 15) return "Naharun Sa'id, Ahmad";
    if (hour < 18) return "Masa'ul Khair, Ahmad";
    return "Lailatun Sa'idah, Ahmad";
  }

  Widget _buildStatusCard(SholatScheduleEntity schedule) {
    final format = DateFormat('HH:mm');
    final nowTimeStr = format.format(_now);

    final prayers = [
      _PrayerTime('Imsak', schedule.imsak, _now),
      _PrayerTime('Subuh', schedule.subuh, _now),
      _PrayerTime('Dhuha', schedule.dhuha, _now),
      _PrayerTime('Dzuhur', schedule.dzuhur, _now),
      _PrayerTime('Ashar', schedule.ashar, _now),
      _PrayerTime('Maghrib', schedule.maghrib, _now),
      _PrayerTime('Isya', schedule.isya, _now),
    ];

    _PrayerTime? nextPrayer;
    for (var p in prayers) {
      if (format.parse(p.timeString).isAfter(format.parse(nowTimeStr))) {
         nextPrayer = p;
         break;
      }
    }

    String countdownText = 'Waiting tomorrow';
    if (nextPrayer != null) {
      final remaining = nextPrayer.time.difference(_now);
      final hours = remaining.inHours;
      final minutes = remaining.inMinutes % 60;
      if (hours > 0) {
        countdownText = '$hours jam $minutes menit menuju ${nextPrayer.name}';
      } else {
        countdownText = '$minutes menit menuju ${nextPrayer.name}';
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E3A8A), // deep blue card
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               Container(
                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                 decoration: BoxDecoration(
                   color: const Color(0xFF172554), // darker blue pill
                   borderRadius: BorderRadius.circular(12),
                 ),
                 child: Row(
                   children: [
                      const Icon(Icons.location_on, color: Colors.orange, size: 14),
                      const SizedBox(width: 4),
                      Text(
                         schedule.cityName.isNotEmpty ? schedule.cityName : 'Mencari lokasi...',
                         style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                   ]
                 ),
               ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                 DateFormat('HH:mm').format(_now),
                 style: const TextStyle(
                   color: Colors.white,
                   fontSize: 48,
                   fontWeight: FontWeight.bold,
                 ),
               ),
               InkWell(
                 onTap: () {
                    context.pushNamed(RouteNames.qibla);
                 },
                 child: Container(
                   padding: const EdgeInsets.all(16),
                   decoration: BoxDecoration(
                     color: Colors.orange,
                     borderRadius: BorderRadius.circular(16),
                   ),
                   child: const Icon(Icons.explore, color: Colors.white, size: 28),
                 ),
               ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
               color: Colors.white.withValues(alpha: 0.1),
               borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
               children: [
                  Container(
                     padding: const EdgeInsets.all(8),
                     decoration: BoxDecoration(
                       color: Colors.orange.withValues(alpha: 0.2),
                       shape: BoxShape.circle,
                     ),
                     child: const Icon(Icons.access_time_filled, color: Colors.orange, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                           countdownText,
                           style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                         ),
                         const SizedBox(height: 2),
                         if (nextPrayer != null)
                           Text(
                             'Waktu ${nextPrayer.name}: ${nextPrayer.timeString} WIB',
                             style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12),
                           )
                      ]
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.white),
               ]
            ),
          )
        ],
      )
    );
  }

  Widget _buildDateCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _cardBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.orange, size: 14),
                      const SizedBox(width: 6),
                      Text('MASEHI', style: TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)),
                    ]
                  ),
                  const SizedBox(height: 8),
                  Text(
                    DateFormat('E, d MMM\nyyyy').format(_now),
                    style: TextStyle(color: _textColor, fontWeight: FontWeight.bold, height: 1.4),
                  )
                ]
              ),
            )
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _cardBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.nightlight_round, color: Colors.orange, size: 14),
                      const SizedBox(width: 6),
                      Text('HIJRIYAH', style: TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)),
                    ]
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${HijriCalendar.fromDate(_now).hDay} ${HijriCalendar.fromDate(_now).longMonthName}\n${HijriCalendar.fromDate(_now).hYear} H',
                    style: TextStyle(color: _textColor, fontWeight: FontWeight.bold, height: 1.4),
                  )
                ]
              ),
            )
          )
        ]
      )
    );
  }

  Widget _buildMenuSection() {
    final menus = [
      {'title': 'Al-Qur\'an', 'icon': Icons.menu_book, 'route': RouteNames.quran},
      {
        'title': 'Hadis',
        'icon': Icons.library_books,
        'route': RouteNames.hadis,
      },
      {'title': 'Dzikir & Doa', 'icon': Icons.auto_stories, 'route': RouteNames.quran},
      {
        'title': 'Kalender Islam',
        'icon': Icons.calendar_month,
        'route': RouteNames.kalender,
      },
      {
        'title': 'Arah Kiblat',
        'icon': Icons.explore,
        'route': RouteNames.qibla,
      },
      {
        'title': 'Jadwal Sholat',
        'icon': Icons.access_time_filled,
        'route': RouteNames.sholat,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
             children: [
                Container(width: 4, height: 20, color: Colors.orange),
                const SizedBox(width: 8),
                Text('Menu Utama', style: TextStyle(color: _textColor, fontSize: 18, fontWeight: FontWeight.bold)),
             ]
           ),
           const SizedBox(height: 24),
           GridView.builder(
             shrinkWrap: true,
             padding: EdgeInsets.zero,
             physics: const NeverScrollableScrollPhysics(),
             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 3,
               mainAxisSpacing: 24,
               crossAxisSpacing: 16,
               childAspectRatio: 0.8,
             ),
             itemCount: menus.length,
             itemBuilder: (context, index) {
               return InkWell(
                 onTap: () {
                    context.pushNamed(menus[index]['route'] as String);
                 },
                 child: Column(
                   children: [
                     Container(
                       padding: const EdgeInsets.all(20),
                       decoration: BoxDecoration(
                         color: _cardBg,
                         borderRadius: BorderRadius.circular(20),
                       ),
                       child: Icon(menus[index]['icon'] as IconData, color: Colors.orange, size: 28),
                     ),
                     const SizedBox(height: 12),
                     Text(
                       menus[index]['title'] as String,
                       textAlign: TextAlign.center,
                       style: TextStyle(color: _textColor, fontSize: 12),
                       maxLines: 2,
                     )
                   ]
                 ),
               );
             }
           )
        ]
      )
    );
  }

  Widget _buildQuoteSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
             children: [
                Container(width: 4, height: 20, color: Colors.orange),
                const SizedBox(width: 8),
                Text('Kutipan Harian', style: TextStyle(color: _textColor, fontSize: 18, fontWeight: FontWeight.bold)),
             ]
           ),
           const SizedBox(height: 24),
           Container(
             width: double.infinity,
             padding: const EdgeInsets.all(24),
             decoration: BoxDecoration(
               color: const Color(0xFF1E3A8A),
               borderRadius: BorderRadius.circular(24),
             ),
             child: Column(
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Container(
                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                       decoration: BoxDecoration(
                         color: Colors.white.withValues(alpha: 0.1),
                         borderRadius: BorderRadius.circular(20),
                       ),
                       child: const Text('AYAT HARI INI', style: TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)),
                     ),
                     Container(
                       padding: const EdgeInsets.all(8),
                       decoration: BoxDecoration(
                         color: Colors.white.withValues(alpha: 0.1),
                         shape: BoxShape.circle,
                       ),
                       child: const Icon(Icons.share, color: Colors.grey, size: 16),
                     )
                   ]
                 ),
                 const SizedBox(height: 24),
                 const Text(
                   'إِنَّ مَعَ ٱلْعُسْرِ يُسْرًا',
                   style: TextStyle(color: Colors.orange, fontSize: 32, fontWeight: FontWeight.bold, height: 1.5),
                   textAlign: TextAlign.center,
                 ),
                 const SizedBox(height: 16),
                 const Text(
                   '"Indeed, with hardship [will be] ease."',
                   style: TextStyle(color: Colors.white, fontSize: 14, fontStyle: FontStyle.italic),
                   textAlign: TextAlign.center,
                 ),
                 const SizedBox(height: 24),
                 const Divider(color: Colors.white24),
                 const SizedBox(height: 16),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text('ASH-SHARH: 6', style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12, fontWeight: FontWeight.bold)),
                     Container(
                       width: 16, height: 16,
                       decoration: const BoxDecoration(color: Colors.teal, shape: BoxShape.circle),
                       child: const Icon(Icons.star, color: Colors.white, size: 10),
                     )
                   ]
                 )
               ]
             )
           )
        ]
      )
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

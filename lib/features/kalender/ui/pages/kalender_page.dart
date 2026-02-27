import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/app_header.dart';

class KalenderPage extends StatefulWidget {
  const KalenderPage({super.key});

  @override
  State<KalenderPage> createState() => _KalenderPageState();
}

class _KalenderPageState extends State<KalenderPage> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late HijriCalendar _todayHijri;

  bool get _isDark => Theme.of(context).brightness == Brightness.dark;
  Color get _textColor => _isDark ? AppColors.darkText : AppColors.black;
  Color get _subTextColor =>
      _isDark ? AppColors.darkTextSecondary : AppColors.grey;
  Color get _cardBg => _isDark ? AppColors.darkSurface : AppColors.white;

  @override
  void initState() {
    super.initState();
    HijriCalendar.setLocal('en');
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _todayHijri = HijriCalendar.now();
  }

  // Calculate Hijri date from a given Gregorian DateTime safely
  HijriCalendar _getHijri(DateTime date) {
    try {
      return HijriCalendar.fromDate(date);
    } catch (_) {
      // Fallback
      return HijriCalendar.now();
    }
  }

  bool _isWhiteDay(int hijriDay) {
    return hijriDay == 13 || hijriDay == 14 || hijriDay == 15;
  }

  DateTime _hijriToGregorian(int year, int month, int day) {
    try {
      final h = HijriCalendar()
        ..hYear = year
        ..hMonth = month
        ..hDay = day;
      return h.hijriToGregorian(year, month, day);
    } catch (_) {
      return DateTime.now();
    }
  }

  Widget _buildTopHeader() {
    // Current actual today's Hijri
    final todayStr =
        '${_todayHijri.hDay} ${_todayHijri.longMonthName} ${_todayHijri.hYear} H';

    final todayGregorian = DateTime.now();
    final formattedGregorian = DateFormat(
      'EEEE, MMM d yyyy',
    ).format(todayGregorian);

    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          todayStr,
          style: AppTypography.textTheme.headlineLarge?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _subTextColor.withValues(alpha: 0.1)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.calendar_today,
                color: AppColors.primary,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                formattedGregorian,
                style: TextStyle(color: _textColor, fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildCustomHeader() {
    // We will base the header on the currently focused day in the calendar.
    // Sometimes a Gregorian month spans two Hijri months. We could show both, e.g. "Rajab - Sha'ban 1447"
    final startOfMonth = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final endOfMonth = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
    final hijriStart = _getHijri(startOfMonth);
    final hijriEnd = _getHijri(endOfMonth);

    String hijriHeader;
    if (hijriStart.hMonth == hijriEnd.hMonth) {
      hijriHeader = '${hijriStart.longMonthName} ${hijriStart.hYear}';
    } else {
      hijriHeader =
          '${hijriStart.longMonthName} - ${hijriEnd.longMonthName} ${hijriStart.hYear}';
    }

    final gregorianHeader = DateFormat('MMMM yyyy').format(_focusedDay);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.chevron_left, color: _textColor),
            onPressed: () {
              setState(() {
                _focusedDay = DateTime(
                  _focusedDay.year,
                  _focusedDay.month - 1,
                  _focusedDay.day,
                );
              });
            },
          ),
          Column(
            children: [
              Text(
                hijriHeader,
                style: TextStyle(
                  color: _textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                gregorianHeader,
                style: TextStyle(color: _subTextColor, fontSize: 12),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.chevron_right, color: _textColor),
            onPressed: () {
              setState(() {
                _focusedDay = DateTime(
                  _focusedDay.year,
                  _focusedDay.month + 1,
                  _focusedDay.day,
                );
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCell(
    DateTime day, {
    bool isToday = false,
    bool isSelected = false,
    bool isOutside = false,
  }) {
    final hijriDate = _getHijri(day);
    final isWhiteDayLocal = _isWhiteDay(hijriDate.hDay);
    final isFriday = day.weekday == DateTime.friday;

    Color bgColor = Colors.transparent;
    Color textColor = _textColor;
    Color subTextColor = _subTextColor;
    BoxBorder? border;

    if (isOutside) {
      textColor = _subTextColor.withValues(alpha: 0.3);
      subTextColor = _subTextColor.withValues(alpha: 0.2);
    } else {
      if (isSelected || isToday) {
        bgColor = AppColors.primary;
        textColor = Colors.black;
        subTextColor = Colors.black87;
      } else {
        if (isFriday) {
          textColor = AppColors.primary;
        }
        if (isWhiteDayLocal) {
          border = Border.all(
            color: _subTextColor.withValues(alpha: 0.3),
            width: 1.5,
          );
        }
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: border,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              day.day.toString(),
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 1),
            Text(
              hijriDate.hDay.toString(),
              style: TextStyle(color: subTextColor, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarCard() {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _subTextColor.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          _buildCustomHeader(),
          Divider(color: _subTextColor.withValues(alpha: 0.15), height: 1),
          TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _focusedDay,
            currentDay: DateTime.now(),
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            headerVisible: false,
            daysOfWeekHeight: 40,
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarBuilders: CalendarBuilders(
              dowBuilder: (context, day) {
                final text = DateFormat.E().format(day)[0];
                final isFriday = day.weekday == DateTime.friday;
                return Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: isFriday ? AppColors.primary : _subTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                );
              },
              defaultBuilder: (context, day, focusedDay) => _buildCell(day),
              todayBuilder: (context, day, focusedDay) =>
                  _buildCell(day, isToday: true),
              selectedBuilder: (context, day, focusedDay) =>
                  _buildCell(day, isSelected: true),
              outsideBuilder: (context, day, focusedDay) =>
                  _buildCell(day, isOutside: true),
            ),
          ),
          Divider(color: _subTextColor.withValues(alpha: 0.15), height: 1),
          // Legend
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'White Days',
                      style: TextStyle(color: _subTextColor, fontSize: 12),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Fri',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Jumu'ah",
                      style: TextStyle(color: _subTextColor, fontSize: 12),
                    ),
                  ],
                ),
                Text(
                  'Maghrib Shift',
                  style: TextStyle(
                    color: _subTextColor.withValues(alpha: 0.3),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Upcoming Events Calculation ---
  Map<String, dynamic> _getNextEvent(
    String name,
    int month,
    int day,
    IconData icon,
    Color bg,
  ) {
    int year = _todayHijri.hYear;
    if (_todayHijri.hMonth > month ||
        (_todayHijri.hMonth == month && _todayHijri.hDay > day)) {
      year++;
    }
    final eventGreg = _hijriToGregorian(year, month, day);
    final todayGreg = DateTime.now();
    int diffDays = eventGreg.difference(todayGreg).inDays;

    String progressLabel = '';
    double progress = 0;
    if (name == 'Ramadan') {
      progressLabel = '${_todayHijri.longMonthName} ${_todayHijri.hDay}';
      progress = 1.0 - (diffDays / 354.0);
      progress = progress.clamp(0.0, 1.0);
    }

    return {
      'title': '$name $year',
      'subtitle':
          '${name == 'Ramadan' ? 'Begins' : 'Expected'} ${DateFormat('MMMM d, yyyy').format(eventGreg)}',
      'days_left': 'In $diffDays Days',
      'icon': icon,
      'bg': bg,
      'progress_label': progressLabel,
      'progress': progress,
    };
  }

  Widget _buildUpcomingEvents() {
    final ramadan = _getNextEvent(
      'Ramadan',
      9,
      1,
      Icons.nights_stay,
      Colors.indigo,
    );
    final eidFitr = _getNextEvent(
      'Eid al-Fitr',
      10,
      1,
      Icons.celebration,
      const Color(0xFF2C3E50),
    );
    final arafah = _getNextEvent(
      'Arafah',
      12,
      9,
      Icons.mosque,
      const Color(0xFF2C3E50),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Upcoming Events',
                style: TextStyle(
                  color: _textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Text(
                'See all',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        _buildEventCard(ramadan, true),
        const SizedBox(height: 16),
        _buildEventCard(eidFitr, false),
        const SizedBox(height: 16),
        _buildEventCard(arafah, false),
      ],
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event, bool isRamadan) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: event['bg'] as Color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  event['icon'] as IconData,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event['title'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      event['subtitle'] as String,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  event['days_left'] as String,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          if (isRamadan) ...[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Countdown',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 12,
                  ),
                ),
                Text(
                  event['progress_label'] as String,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: event['progress'] as double,
                backgroundColor: Colors.black.withValues(alpha: 0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
                minHeight: 6,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      header: AppHeader.classic(
        title: 'Kalender Hijriah',
        onMenuPressed: () => Scaffold.of(context).openDrawer(),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined, color: _textColor),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              _buildTopHeader(),
              _buildCalendarCard(),
              _buildUpcomingEvents(),
              const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';

class DateCards extends StatelessWidget {
  final DateTime now;
  final Color cardBg;
  final Color textColor;

  const DateCards({
    super.key,
    required this.now,
    required this.cardBg,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.orange, size: 14),
                      const SizedBox(width: 6),
                      const Text('MASEHI', style: TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    DateFormat('E, d MMM\nyyyy').format(now),
                    style: TextStyle(color: textColor, fontWeight: FontWeight.bold, height: 1.4),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.nightlight_round, color: Colors.orange, size: 14),
                      const SizedBox(width: 6),
                      const Text('HIJRIYAH', style: TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${HijriCalendar.fromDate(now).hDay} ${HijriCalendar.fromDate(now).longMonthName}\n${HijriCalendar.fromDate(now).hYear} H',
                    style: TextStyle(color: textColor, fontWeight: FontWeight.bold, height: 1.4),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

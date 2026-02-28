import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../sholat/domain/entities/sholat_schedule_entity.dart';
import 'prayer_time.dart';

class StatusCard extends StatelessWidget {
  final SholatScheduleEntity schedule;
  final DateTime now;
  final VoidCallback onQiblaTap;

  const StatusCard({
    super.key,
    required this.schedule,
    required this.now,
    required this.onQiblaTap,
  });

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('HH:mm');
    final nowTimeStr = format.format(now);

    final prayers = [
      PrayerTime('Imsak', schedule.imsak, now),
      PrayerTime('Subuh', schedule.subuh, now),
      PrayerTime('Dhuha', schedule.dhuha, now),
      PrayerTime('Dzuhur', schedule.dzuhur, now),
      PrayerTime('Ashar', schedule.ashar, now),
      PrayerTime('Maghrib', schedule.maghrib, now),
      PrayerTime('Isya', schedule.isya, now),
    ];

    PrayerTime? nextPrayer;
    for (var p in prayers) {
      if (format.parse(p.timeString).isAfter(format.parse(nowTimeStr))) {
        nextPrayer = p;
        break;
      }
    }

    String countdownText = 'Waiting tomorrow';
    if (nextPrayer != null) {
      final remaining = nextPrayer.time.difference(now);
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
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('HH:mm').format(now),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: onQiblaTap,
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
                        ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

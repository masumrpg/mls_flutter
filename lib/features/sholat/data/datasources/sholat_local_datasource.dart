import '../../../../core/database/app_database.dart';
import '../../../../core/error/exception.dart';
import '../models/sholat_schedule_model.dart';
import 'package:drift/drift.dart';

abstract class SholatLocalDataSource {
  Future<void> cacheSchedule(SholatScheduleModel schedule);
  Future<SholatScheduleModel?> getCachedSchedule(String cityId, String date);
  Future<void> saveNotificationSetting(String prayerName, int alertType, int preReminderMinutes);
  Future<Map<String, dynamic>> getNotificationSettings();
}

class SholatLocalDataSourceImpl implements SholatLocalDataSource {
  final AppDatabase db;

  SholatLocalDataSourceImpl(this.db);

  @override
  Future<void> cacheSchedule(SholatScheduleModel schedule) async {
    try {
      await db.into(db.prayerSchedulesTable).insertOnConflictUpdate(
        PrayerSchedulesTableCompanion(
          id: Value('${schedule.cityId}_${schedule.date}'),
          cityId: Value(schedule.cityId),
          cityName: Value(schedule.cityName),
          province: Value(schedule.province),
          date: Value(schedule.date),
          imsak: Value(schedule.imsak),
          subuh: Value(schedule.subuh),
          terbit: Value(schedule.terbit),
          dhuha: Value(schedule.dhuha),
          dzuhur: Value(schedule.dzuhur),
          ashar: Value(schedule.ashar),
          maghrib: Value(schedule.maghrib),
          isya: Value(schedule.isya),
        )
      );
    } catch (e) {
      throw CacheException('Failed to cache schedule: $e');
    }
  }

  @override
  Future<SholatScheduleModel?> getCachedSchedule(String cityId, String date) async {
    try {
      final query = db.select(db.prayerSchedulesTable)..where((t) => t.id.equals('${cityId}_$date'));
      final result = await query.getSingleOrNull();

      if (result != null) {
        return SholatScheduleModel(
          cityId: result.cityId,
          cityName: result.cityName,
          province: result.province,
          date: result.date,
          imsak: result.imsak,
          subuh: result.subuh,
          terbit: result.terbit,
          dhuha: result.dhuha,
          dzuhur: result.dzuhur,
          ashar: result.ashar,
          maghrib: result.maghrib,
          isya: result.isya,
        );
      }
    } catch (e) {
      throw CacheException('Failed to get cached schedule: $e');
    }
    return null;
  }

  @override
  Future<void> saveNotificationSetting(String prayerName, int alertType, int preReminderMinutes) async {
    try {
      await db.into(db.notificationSettingsTable).insertOnConflictUpdate(
        NotificationSettingsTableCompanion(
          prayerName: Value(prayerName),
          alertType: Value(alertType),
          preReminderMinutes: Value(preReminderMinutes),
        ),
      );
    } catch (e) {
      throw CacheException('Failed to save notification setting: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getNotificationSettings() async {
    try {
      final settings = await db.select(db.notificationSettingsTable).get();
      final Map<String, dynamic> result = {};
      for (var s in settings) {
        result[s.prayerName] = {
          'alertType': s.alertType,
          'preReminderMinutes': s.preReminderMinutes,
        };
      }
      return result;
    } catch (e) {
      throw CacheException('Failed to get notification settings: $e');
    }
  }
}

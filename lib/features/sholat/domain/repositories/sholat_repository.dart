import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/city_entity.dart';
import '../entities/sholat_schedule_entity.dart';

abstract class SholatRepository {
  Future<Either<Failure, List<CityEntity>>> getCities();
  Future<Either<Failure, List<CityEntity>>> searchCities(String keyword);
  Future<Either<Failure, SholatScheduleEntity>> getScheduleToday(String cityId);
  Future<Either<Failure, SholatScheduleEntity>> getSchedule(
    String cityId,
    String date,
  );
  Future<Either<Failure, SholatScheduleEntity>> getScheduleForCurrentLocation();
  Future<Either<Failure, void>> saveNotificationSetting(
    String prayerName,
    int alertType,
    int preReminderMinutes,
  );
  Future<Either<Failure, Map<String, dynamic>>> getNotificationSettings();
}

import 'package:fpdart/fpdart.dart';
import 'package:intl/intl.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/services/location_service.dart';
import '../../domain/entities/city_entity.dart';
import '../../domain/entities/sholat_schedule_entity.dart';
import '../../domain/repositories/sholat_repository.dart';
import '../datasources/sholat_remote_datasource.dart';
import '../datasources/sholat_local_datasource.dart';

class SholatRepositoryImpl implements SholatRepository {
  final SholatRemoteDataSource remoteDataSource;
  final SholatLocalDataSource localDataSource;
  final LocationService locationService;

  SholatRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.locationService,
  });

  @override
  Future<Either<Failure, List<CityEntity>>> getCities() async {
    try {
      final cities = await remoteDataSource.getCities();
      return Right(cities);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CityEntity>>> searchCities(String keyword) async {
    try {
      final cities = await remoteDataSource.searchCities(keyword);
      return Right(cities);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SholatScheduleEntity>> getScheduleToday(
    String cityId,
  ) async {
    final todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return getSchedule(cityId, todayStr);
  }

  @override
  Future<Either<Failure, SholatScheduleEntity>> getSchedule(
    String cityId,
    String date,
  ) async {
    try {
      // 1. Check local cache
      final cached = await localDataSource.getCachedSchedule(cityId, date);
      if (cached != null) {
        return Right(cached);
      }

      // 2. Fetch from remote
      final remote = await remoteDataSource.getSchedule(cityId, date);

      // 3. Cache it
      await localDataSource.cacheSchedule(remote);

      return Right(remote);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SholatScheduleEntity>>
  getScheduleForCurrentLocation() async {
    try {
      // 1. Get location string
      final cityName = await locationService.getCityName();
      if (cityName == null || cityName.isEmpty) {
        return const Left(ServerFailure('Gagal mendapatkan lokasi saat ini.'));
      }

      // Cleanup city name if it contains "Kota " or "Kabupaten " which might not perfectly match MyQuran API but usually does.
      final cleanCity = cityName
          .replaceAll(
            RegExp(r'Kota\s+|Kabupaten\s+|Kab\.\s+', caseSensitive: false),
            '',
          )
          .trim();

      // 2. Search city from API
      final cities = await remoteDataSource.searchCities(cleanCity);
      if (cities.isEmpty) {
        // Fallback to searching the full original name just in case
        final citiesFallback = await remoteDataSource.searchCities(cityName);
        if (citiesFallback.isEmpty) {
          return Left(
            ServerFailure('Kota $cityName tidak ditemukan di database jadwal.'),
          );
        }
        return getScheduleToday(citiesFallback.first.id);
      }

      // 3. Fetch schedule
      return getScheduleToday(cities.first.id);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveNotificationSetting(
    String prayerName,
    int alertType,
    int preReminderMinutes,
  ) async {
    try {
      await localDataSource.saveNotificationSetting(
        prayerName,
        alertType,
        preReminderMinutes,
      );
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>>
  getNotificationSettings() async {
    try {
      final settings = await localDataSource.getNotificationSettings();
      return Right(settings);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}

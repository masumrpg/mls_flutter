import 'package:fpdart/fpdart.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/city_entity.dart';
import '../../domain/entities/sholat_schedule_entity.dart';
import '../../domain/repositories/sholat_repository.dart';
import '../datasources/sholat_remote_datasource.dart';

class SholatRepositoryImpl implements SholatRepository {
  final SholatRemoteDataSource remoteDataSource;

  SholatRepositoryImpl(this.remoteDataSource);

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
  Future<Either<Failure, SholatScheduleEntity>> getScheduleToday(String cityId) async {
    try {
      final schedule = await remoteDataSource.getScheduleToday(cityId);
      return Right(schedule);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SholatScheduleEntity>> getSchedule(String cityId, String date) async {
    try {
      final schedule = await remoteDataSource.getSchedule(cityId, date);
      return Right(schedule);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

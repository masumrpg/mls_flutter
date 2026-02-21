import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/exception.dart';
import '../../domain/repositories/quran_repository.dart';
import '../../domain/entities/quran_entity.dart';
import '../../domain/entities/surah_detail_entity.dart';
import '../datasources/quran_remote_datasource.dart';
import '../datasources/quran_local_datasource.dart';

class QuranRepositoryImpl implements QuranRepository {
  final QuranRemoteDataSource remoteDataSource;
  final QuranLocalDataSource localDataSource;

  QuranRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<SurahEntity>>> getSurahs() async {
    try {
      // Try local first
      final hasLocal = await localDataSource.hasSurahs();
      if (hasLocal) {
        final localSurahs = await localDataSource.getSurahs();
        return Right(localSurahs.map((e) => e.toEntity()).toList());
      }

      // Fallback to remote
      final models = await remoteDataSource.getSurahs();
      await localDataSource.saveSurahs(models);
      return Right(models.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SurahEntity>>> refreshSurahs() async {
    try {
      // Force fetch from remote
      final models = await remoteDataSource.getSurahs();
      await localDataSource.saveSurahs(models);
      return Right(models.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SurahDetailEntity>> getSurahDetail(int surahNumber) async {
    try {
      // Try local first
      final localDetail = await localDataSource.getSurahDetail(surahNumber);

      // Only return local cache if ALL ayahs are present
      if (localDetail != null &&
          localDetail.ayahs.length == localDetail.numberOfAyahs) {
        return Right(localDetail.toEntity());
      }

      // Fallback to remote if missing ayahs or missing completely
      final model = await remoteDataSource.getSurahDetail(surahNumber);
      await localDataSource.saveSurahDetail(model);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SurahDetailEntity>> refreshSurahDetail(
    int surahNumber,
  ) async {
    try {
      // Force fetch from remote
      final model = await remoteDataSource.getSurahDetail(surahNumber);
      await localDataSource.saveSurahDetail(model);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

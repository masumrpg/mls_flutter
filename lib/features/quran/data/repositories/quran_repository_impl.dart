import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/exception.dart';
import '../../domain/repositories/quran_repository.dart';
import '../../domain/entities/quran_entity.dart';
import '../../domain/entities/surah_detail_entity.dart';
import '../datasources/quran_remote_datasource.dart';

class QuranRepositoryImpl implements QuranRepository {
  final QuranRemoteDataSource remoteDataSource;

  QuranRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<SurahEntity>>> getSurahs() async {
    try {
      final models = await remoteDataSource.getSurahs();
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
      final model = await remoteDataSource.getSurahDetail(surahNumber);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/exception.dart';
import '../../domain/repositories/hadis_repository.dart';
import '../../domain/entities/hadis_entity.dart';
import '../datasources/hadis_remote_datasource.dart';

class HadisRepositoryImpl implements HadisRepository {
  final HadisRemoteDataSource remoteDataSource;

  HadisRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, HadisExploreEntity>> exploreHadis({int page = 1, int limit = 10}) async {
    try {
      final model = await remoteDataSource.exploreHadis(page: page, limit: limit);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

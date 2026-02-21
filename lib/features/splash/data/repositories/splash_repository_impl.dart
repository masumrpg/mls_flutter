import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/exception.dart';
import '../../domain/repositories/splash_repository.dart';
import '../../domain/entities/splash_entity.dart';
import '../datasources/splash_remote_datasource.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashRemoteDataSource remoteDataSource;

  SplashRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<SplashEntity>>> getItems() async {
    try {
      final models = await remoteDataSource.getItems();
      return Right(models.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

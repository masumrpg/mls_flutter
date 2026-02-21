import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/exception.dart';
import '../../domain/repositories/qibla_repository.dart';
import '../../domain/entities/qibla_entity.dart';
import '../datasources/qibla_remote_datasource.dart';

class QiblaRepositoryImpl implements QiblaRepository {
  final QiblaRemoteDataSource remoteDataSource;

  QiblaRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<QiblaEntity>>> getItems() async {
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

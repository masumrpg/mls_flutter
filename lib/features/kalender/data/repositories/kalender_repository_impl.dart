import 'package:fpdart/fpdart.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/kalender_entity.dart';
import '../../domain/repositories/kalender_repository.dart';
import '../datasources/kalender_remote_datasource.dart';

class KalenderRepositoryImpl implements KalenderRepository {
  final KalenderRemoteDataSource remoteDataSource;

  KalenderRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, KalenderEntity>> getKalenderToday() async {
    try {
      final result = await remoteDataSource.getKalenderToday();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred: $e'));
    }
  }
}

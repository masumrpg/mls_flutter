import 'package:fpdart/fpdart.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/profil_entity.dart';
import '../../domain/repositories/profil_repository.dart';
import '../datasources/profil_remote_datasource.dart';

class ProfilRepositoryImpl implements ProfilRepository {
  final ProfilRemoteDataSource remoteDataSource;

  ProfilRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ProfilEntity>> getProfilStats() async {
    try {
      final result = await remoteDataSource.getProfilStats();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred: $e'));
    }
  }
}

import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/hadis_model.dart';

abstract class HadisRepository {
  Future<Either<Failure, HadisResponseModel>> getExplore(int page, int limit);
  Future<Either<Failure, HadisResponseModel>> searchHadis(
    String query,
    int page,
    int limit,
  );
  Future<Either<Failure, HadisModel>> getHadisDetail(int id);
}

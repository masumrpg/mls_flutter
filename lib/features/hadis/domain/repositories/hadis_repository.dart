import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/hadis_entity.dart';

abstract class HadisRepository {
  Future<Either<Failure, HadisExploreEntity>> exploreHadis({int page = 1, int limit = 10});
}

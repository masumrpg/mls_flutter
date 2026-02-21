import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/splash_entity.dart';

abstract class SplashRepository {
  Future<Either<Failure, List<SplashEntity>>> getItems();
  // Future<Either<Failure, SplashEntity>> getItemById(String id);
}

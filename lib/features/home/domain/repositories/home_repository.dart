import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/home_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<HomeEntity>>> getItems();
  // Future<Either<Failure, HomeEntity>> getItemById(String id);
}

import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, List<ProfileEntity>>> getItems();
  // Future<Either<Failure, ProfileEntity>> getItemById(String id);
}

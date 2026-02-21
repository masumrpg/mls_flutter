import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, List<AuthEntity>>> getItems();
  // Future<Either<Failure, AuthEntity>> getItemById(String id);
}

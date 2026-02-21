import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/profil_entity.dart';

abstract class ProfilRepository {
  Future<Either<Failure, ProfilEntity>> getProfilStats();
}

import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/qibla_entity.dart';

abstract class QiblaRepository {
  Future<Either<Failure, QiblaEntity>> getQibla(double latitude, double longitude);
}

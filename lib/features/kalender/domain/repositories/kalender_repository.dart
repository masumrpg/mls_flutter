import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/kalender_entity.dart';

abstract class KalenderRepository {
  Future<Either<Failure, KalenderEntity>> getKalenderToday();
}

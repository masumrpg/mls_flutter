import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/dashboard_entity.dart';

abstract class DashboardRepository {
  Future<Either<Failure, List<DashboardEntity>>> getItems();
  // Future<Either<Failure, DashboardEntity>> getItemById(String id);
}

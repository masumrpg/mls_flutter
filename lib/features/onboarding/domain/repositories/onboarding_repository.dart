import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/onboarding_entity.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, List<OnboardingEntity>>> getItems();
  // Future<Either<Failure, OnboardingEntity>> getItemById(String id);
}

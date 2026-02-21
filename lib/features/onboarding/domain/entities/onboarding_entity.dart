import 'package:equatable/equatable.dart';

class OnboardingEntity extends Equatable {
  final String id;
  final String name;

  const OnboardingEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

import 'package:equatable/equatable.dart';

class SplashEntity extends Equatable {
  final String id;
  final String name;

  const SplashEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

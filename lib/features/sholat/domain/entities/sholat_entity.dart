import 'package:equatable/equatable.dart';

class SholatEntity extends Equatable {
  final String id;
  final String name;

  const SholatEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

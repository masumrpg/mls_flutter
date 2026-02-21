import 'package:equatable/equatable.dart';

class DashboardEntity extends Equatable {
  final String id;
  final String name;

  const DashboardEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

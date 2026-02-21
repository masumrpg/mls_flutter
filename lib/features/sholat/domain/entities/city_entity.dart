import 'package:equatable/equatable.dart';

class CityEntity extends Equatable {
  final String id;
  final String location;

  const CityEntity({required this.id, required this.location});

  @override
  List<Object?> get props => [id, location];
}

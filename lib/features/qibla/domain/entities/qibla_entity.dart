import 'package:equatable/equatable.dart';

class QiblaEntity extends Equatable {
  final double latitude;
  final double longitude;
  final double direction;

  const QiblaEntity({
    required this.latitude,
    required this.longitude,
    required this.direction,
  });

  @override
  List<Object?> get props => [latitude, longitude, direction];
}

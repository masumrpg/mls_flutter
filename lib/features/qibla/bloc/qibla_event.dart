part of 'qibla_bloc.dart';

abstract class QiblaEvent extends Equatable {
  const QiblaEvent();

  @override
  List<Object?> get props => [];
}

class FetchQibla extends QiblaEvent {
  final double latitude;
  final double longitude;

  const FetchQibla({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}

part of 'qibla_bloc.dart';

abstract class QiblaState extends Equatable {
  const QiblaState();

  @override
  List<Object?> get props => [];
}

class QiblaInitial extends QiblaState {}

class QiblaLoading extends QiblaState {}

class QiblaLoaded extends QiblaState {
  final QiblaEntity qibla;

  const QiblaLoaded(this.qibla);

  @override
  List<Object?> get props => [qibla];
}

class QiblaError extends QiblaState {
  final String message;

  const QiblaError(this.message);

  @override
  List<Object?> get props => [message];
}

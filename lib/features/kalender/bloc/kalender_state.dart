import 'package:equatable/equatable.dart';
import '../domain/entities/kalender_entity.dart';

abstract class KalenderState extends Equatable {
  const KalenderState();

  @override
  List<Object> get props => [];
}

class KalenderInitial extends KalenderState {}

class KalenderLoading extends KalenderState {}

class KalenderLoaded extends KalenderState {
  final KalenderEntity kalender;

  const KalenderLoaded(this.kalender);

  @override
  List<Object> get props => [kalender];
}

class KalenderError extends KalenderState {
  final String message;

  const KalenderError(this.message);

  @override
  List<Object> get props => [message];
}

part of 'sholat_schedule_bloc.dart';

abstract class SholatScheduleState extends Equatable {
  const SholatScheduleState();

  @override
  List<Object?> get props => [];
}

class SholatScheduleInitial extends SholatScheduleState {}

class SholatScheduleLoading extends SholatScheduleState {}

class SholatScheduleLoaded extends SholatScheduleState {
  final SholatScheduleEntity schedule;

  const SholatScheduleLoaded(this.schedule);

  @override
  List<Object?> get props => [schedule];
}

class SholatScheduleError extends SholatScheduleState {
  final String message;

  const SholatScheduleError(this.message);

  @override
  List<Object?> get props => [message];
}

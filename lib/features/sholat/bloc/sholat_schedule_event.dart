part of 'sholat_schedule_bloc.dart';

abstract class SholatScheduleEvent extends Equatable {
  const SholatScheduleEvent();

  @override
  List<Object?> get props => [];
}

class FetchSholatSchedule extends SholatScheduleEvent {
  final String? cityId;

  const FetchSholatSchedule({this.cityId});

  @override
  List<Object?> get props => [cityId];
}

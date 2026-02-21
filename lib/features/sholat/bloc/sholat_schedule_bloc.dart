import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/entities/sholat_schedule_entity.dart';
import '../domain/repositories/sholat_repository.dart';

part 'sholat_schedule_event.dart';
part 'sholat_schedule_state.dart';

class SholatScheduleBloc
    extends Bloc<SholatScheduleEvent, SholatScheduleState> {
  final SholatRepository repository;

  SholatScheduleBloc({required this.repository})
    : super(SholatScheduleInitial()) {
    on<FetchSholatSchedule>(_onFetchSholatSchedule);
  }

  Future<void> _onFetchSholatSchedule(
    FetchSholatSchedule event,
    Emitter<SholatScheduleState> emit,
  ) async {
    emit(SholatScheduleLoading());

    // Use current location explicitly if cityId is null
    final result = event.cityId == null
        ? await repository.getScheduleForCurrentLocation()
        : await repository.getScheduleToday(event.cityId!);

    result.fold(
      (failure) => emit(SholatScheduleError(failure.message)),
      (schedule) => emit(SholatScheduleLoaded(schedule)),
    );
  }
}

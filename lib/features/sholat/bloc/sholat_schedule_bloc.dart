import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/entities/sholat_schedule_entity.dart';
import '../domain/repositories/sholat_repository.dart';

part 'sholat_schedule_event.dart';
part 'sholat_schedule_state.dart';

class SholatScheduleBloc extends Bloc<SholatScheduleEvent, SholatScheduleState> {
  final SholatRepository repository;

  SholatScheduleBloc({required this.repository}) : super(SholatScheduleInitial()) {
    on<FetchSholatSchedule>(_onFetchSholatSchedule);
  }

  Future<void> _onFetchSholatSchedule(
    FetchSholatSchedule event,
    Emitter<SholatScheduleState> emit,
  ) async {
    emit(SholatScheduleLoading());

    // Default to Jakarta (58a2fc6ed39fd083f55d4182bf88826d) if no city is provided
    final cityId = event.cityId ?? '58a2fc6ed39fd083f55d4182bf88826d';

    final result = await repository.getScheduleToday(cityId);

    result.fold(
      (failure) => emit(SholatScheduleError(failure.message)),
      (schedule) => emit(SholatScheduleLoaded(schedule)),
    );
  }
}

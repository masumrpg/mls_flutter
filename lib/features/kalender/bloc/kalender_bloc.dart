import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/repositories/kalender_repository.dart';
import 'kalender_event.dart';
import 'kalender_state.dart';

class KalenderBloc extends Bloc<KalenderEvent, KalenderState> {
  final KalenderRepository repository;

  KalenderBloc({required this.repository}) : super(KalenderInitial()) {
    on<FetchKalenderToday>(_onFetchKalenderToday);
  }

  Future<void> _onFetchKalenderToday(
    FetchKalenderToday event,
    Emitter<KalenderState> emit,
  ) async {
    emit(KalenderLoading());

    final result = await repository.getKalenderToday();

    result.fold(
      (failure) => emit(KalenderError(failure.message)),
      (kalender) => emit(KalenderLoaded(kalender)),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/entities/qibla_entity.dart';
import '../domain/repositories/qibla_repository.dart';

part 'qibla_event.dart';
part 'qibla_state.dart';

class QiblaBloc extends Bloc<QiblaEvent, QiblaState> {
  final QiblaRepository repository;

  QiblaBloc({required this.repository}) : super(QiblaInitial()) {
    on<FetchQibla>(_onFetchQibla);
  }

  Future<void> _onFetchQibla(
    FetchQibla event,
    Emitter<QiblaState> emit,
  ) async {
    emit(QiblaLoading());
    final result = await repository.getQibla(event.latitude, event.longitude);
    result.fold(
      (failure) => emit(QiblaError(failure.message)),
      (qibla) => emit(QiblaLoaded(qibla)),
    );
  }
}

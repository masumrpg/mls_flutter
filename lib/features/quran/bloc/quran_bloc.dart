import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../domain/repositories/quran_repository.dart';
import '../domain/entities/quran_entity.dart';

part 'quran_event.dart';
part 'quran_state.dart';

class QuranBloc extends Bloc<QuranEvent, QuranState> {
  final QuranRepository repository;

  QuranBloc({required this.repository}) : super(const QuranInitial()) {
    on<FetchSurahs>(_onFetchSurahs);
  }

  Future<void> _onFetchSurahs(
    FetchSurahs event,
    Emitter<QuranState> emit,
  ) async {
    emit(const QuranLoading());
    final result = await repository.getSurahs();
    result.fold(
      (failure) => emit(QuranError(failure.message)),
      (surahs) => emit(QuranLoaded(surahs)),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../domain/repositories/quran_repository.dart';
import '../domain/entities/surah_detail_entity.dart';

part 'surah_detail_event.dart';
part 'surah_detail_state.dart';

class SurahDetailBloc extends Bloc<SurahDetailEvent, SurahDetailState> {
  final QuranRepository repository;

  SurahDetailBloc({required this.repository}) : super(const SurahDetailInitial()) {
    on<FetchSurahDetail>(_onFetchSurahDetail);
  }

  Future<void> _onFetchSurahDetail(
    FetchSurahDetail event,
    Emitter<SurahDetailState> emit,
  ) async {
    emit(const SurahDetailLoading());
    final result = await repository.getSurahDetail(event.surahNumber);
    result.fold(
      (failure) => emit(SurahDetailError(failure.message)),
      (detail) => emit(SurahDetailLoaded(detail)),
    );
  }
}

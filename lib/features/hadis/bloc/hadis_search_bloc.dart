import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/repositories/hadis_repository.dart';
import '../data/models/hadis_model.dart';

part 'hadis_search_event.dart';
part 'hadis_search_state.dart';

class HadisSearchBloc extends Bloc<HadisSearchEvent, HadisSearchState> {
  final HadisRepository repository;
  bool _isFetching = false;

  HadisSearchBloc({required this.repository}) : super(HadisSearchInitial()) {
    on<LoadHadisSearch>(_onLoadHadisSearch);
    on<LoadNextHadisSearch>(_onLoadNextHadisSearch);
  }

  Future<void> _onLoadHadisSearch(
    LoadHadisSearch event,
    Emitter<HadisSearchState> emit,
  ) async {
    if (event.query.length < 4) {
      emit(HadisSearchInitial());
      return;
    }
    emit(HadisSearchLoading());
    _isFetching = true;
    final result = await repository.searchHadis(event.query, 1, 10);
    _isFetching = false;
    result.fold(
      (failure) => emit(HadisSearchError(failure.message)),
      (response) {
        final hasNext = response.paging?.hasNext ?? false;
        emit(HadisSearchLoaded(
          query: event.query,
          hadis: response.hadis,
          hasReachedMax: !hasNext,
          currentPage: 1,
        ));
      },
    );
  }

  Future<void> _onLoadNextHadisSearch(
    LoadNextHadisSearch event,
    Emitter<HadisSearchState> emit,
  ) async {
    if (_isFetching) return;
    final currentState = state;
    if (currentState is HadisSearchLoaded && !currentState.hasReachedMax) {
      _isFetching = true;
      final nextPage = currentState.currentPage + 1;
      final result = await repository.searchHadis(currentState.query, nextPage, 10);
      _isFetching = false;
      result.fold(
        (failure) {
          // Do not emit HadisSearchError to prevent wiping out the loaded list.
        },
        (response) {
          final hasNext = response.paging?.hasNext ?? false;
          emit(HadisSearchLoaded(
            query: currentState.query,
            hadis: List.of(currentState.hadis)..addAll(response.hadis),
            hasReachedMax: !hasNext,
            currentPage: nextPage,
          ));
        },
      );
    }
  }
}

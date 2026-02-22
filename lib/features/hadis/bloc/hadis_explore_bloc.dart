import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/repositories/hadis_repository.dart';
import '../data/models/hadis_model.dart';

part 'hadis_explore_event.dart';
part 'hadis_explore_state.dart';

class HadisExploreBloc extends Bloc<HadisExploreEvent, HadisExploreState> {
  final HadisRepository repository;
  bool _isFetching = false;

  HadisExploreBloc({required this.repository}) : super(HadisExploreInitial()) {
    on<LoadHadisExplore>(_onLoadHadisExplore);
    on<LoadNextHadisExplore>(_onLoadNextHadisExplore);
  }

  Future<void> _onLoadHadisExplore(
    LoadHadisExplore event,
    Emitter<HadisExploreState> emit,
  ) async {
    emit(HadisExploreLoading());
    _isFetching = true;
    final result = await repository.getExplore(1, 10);
    _isFetching = false;
    result.fold(
      (failure) => emit(HadisExploreError(failure.message)),
      (response) {
        final hasNext = response.paging?.hasNext ?? false;
        emit(HadisExploreLoaded(
          hadis: response.hadis,
          hasReachedMax: !hasNext,
          currentPage: 1,
        ));
      },
    );
  }

  Future<void> _onLoadNextHadisExplore(
    LoadNextHadisExplore event,
    Emitter<HadisExploreState> emit,
  ) async {
    if (_isFetching) return;
    final currentState = state;
    if (currentState is HadisExploreLoaded && !currentState.hasReachedMax) {
      _isFetching = true;
      final nextPage = currentState.currentPage + 1;
      final result = await repository.getExplore(nextPage, 10);
      _isFetching = false;
      result.fold(
        (failure) {
          // Do not emit HadisExploreError to prevent wiping out the loaded list.
        },
        (response) {
          final hasNext = response.paging?.hasNext ?? false;
          emit(HadisExploreLoaded(
            hadis: List.of(currentState.hadis)..addAll(response.hadis),
            hasReachedMax: !hasNext,
            currentPage: nextPage,
          ));
        },
      );
    }
  }
}

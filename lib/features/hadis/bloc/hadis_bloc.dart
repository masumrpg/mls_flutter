import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../domain/repositories/hadis_repository.dart';
import '../domain/entities/hadis_entity.dart';

part 'hadis_event.dart';
part 'hadis_state.dart';

class HadisBloc extends Bloc<HadisEvent, HadisState> {
  final HadisRepository repository;

  HadisBloc({required this.repository}) : super(const HadisInitial()) {
    on<FetchHadisExplore>(_onFetchHadisExplore);
  }

  Future<void> _onFetchHadisExplore(
    FetchHadisExplore event,
    Emitter<HadisState> emit,
  ) async {
    emit(const HadisLoading());
    final result = await repository.exploreHadis(page: event.page);
    result.fold(
      (failure) => emit(HadisError(failure.message)),
      (hadisData) => emit(HadisLoaded(hadisData)),
    );
  }
}

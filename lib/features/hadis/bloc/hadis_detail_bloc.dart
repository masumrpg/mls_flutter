import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/repositories/hadis_repository.dart';
import '../data/models/hadis_model.dart';

part 'hadis_detail_event.dart';
part 'hadis_detail_state.dart';

class HadisDetailBloc extends Bloc<HadisDetailEvent, HadisDetailState> {
  final HadisRepository repository;

  HadisDetailBloc({required this.repository}) : super(HadisDetailInitial()) {
    on<LoadHadisDetail>(_onLoadHadisDetail);
  }

  Future<void> _onLoadHadisDetail(
    LoadHadisDetail event,
    Emitter<HadisDetailState> emit,
  ) async {
    emit(HadisDetailLoading());
    final result = await repository.getHadisDetail(event.id);
    result.fold(
      (failure) => emit(HadisDetailError(failure.message)),
      (hadis) => emit(HadisDetailLoaded(hadis)),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/repositories/profil_repository.dart';
import 'profil_event.dart';
import 'profil_state.dart';

class ProfilBloc extends Bloc<ProfilEvent, ProfilState> {
  final ProfilRepository repository;

  ProfilBloc({required this.repository}) : super(ProfilInitial()) {
    on<FetchProfilStats>(_onFetchProfilStats);
  }

  Future<void> _onFetchProfilStats(
    FetchProfilStats event,
    Emitter<ProfilState> emit,
  ) async {
    emit(ProfilLoading());

    final result = await repository.getProfilStats();

    result.fold(
      (failure) => emit(ProfilError(failure.message)),
      (profil) => emit(ProfilLoaded(profil)),
    );
  }
}

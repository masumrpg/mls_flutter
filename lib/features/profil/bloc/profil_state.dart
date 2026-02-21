import 'package:equatable/equatable.dart';
import '../domain/entities/profil_entity.dart';

abstract class ProfilState extends Equatable {
  const ProfilState();

  @override
  List<Object> get props => [];
}

class ProfilInitial extends ProfilState {}

class ProfilLoading extends ProfilState {}

class ProfilLoaded extends ProfilState {
  final ProfilEntity profil;

  const ProfilLoaded(this.profil);

  @override
  List<Object> get props => [profil];
}

class ProfilError extends ProfilState {
  final String message;

  const ProfilError(this.message);

  @override
  List<Object> get props => [message];
}

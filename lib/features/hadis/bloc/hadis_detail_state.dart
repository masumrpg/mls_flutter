part of 'hadis_detail_bloc.dart';

abstract class HadisDetailState extends Equatable {
  const HadisDetailState();

  @override
  List<Object> get props => [];
}

class HadisDetailInitial extends HadisDetailState {}

class HadisDetailLoading extends HadisDetailState {}

class HadisDetailLoaded extends HadisDetailState {
  final HadisModel hadis;

  const HadisDetailLoaded(this.hadis);

  @override
  List<Object> get props => [hadis];
}

class HadisDetailError extends HadisDetailState {
  final String message;

  const HadisDetailError(this.message);

  @override
  List<Object> get props => [message];
}

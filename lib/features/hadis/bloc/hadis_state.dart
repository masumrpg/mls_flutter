part of 'hadis_bloc.dart';

abstract class HadisState extends Equatable {
  const HadisState();

  @override
  List<Object> get props => [];
}

class HadisInitial extends HadisState {
  const HadisInitial();
}

class HadisLoading extends HadisState {
  const HadisLoading();
}

class HadisLoaded extends HadisState {
  final HadisExploreEntity exploreData;

  const HadisLoaded(this.exploreData);

  @override
  List<Object> get props => [exploreData];
}

class HadisError extends HadisState {
  final String message;
  const HadisError(this.message);

  @override
  List<Object> get props => [message];
}

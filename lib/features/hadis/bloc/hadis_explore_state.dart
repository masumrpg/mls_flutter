part of 'hadis_explore_bloc.dart';

abstract class HadisExploreState extends Equatable {
  const HadisExploreState();

  @override
  List<Object> get props => [];
}

class HadisExploreInitial extends HadisExploreState {}

class HadisExploreLoading extends HadisExploreState {}

class HadisExploreLoaded extends HadisExploreState {
  final List<HadisModel> hadis;
  final bool hasReachedMax;
  final int currentPage;

  const HadisExploreLoaded({
    required this.hadis,
    required this.hasReachedMax,
    required this.currentPage,
  });

  @override
  List<Object> get props => [hadis, hasReachedMax, currentPage];
}

class HadisExploreError extends HadisExploreState {
  final String message;

  const HadisExploreError(this.message);

  @override
  List<Object> get props => [message];
}

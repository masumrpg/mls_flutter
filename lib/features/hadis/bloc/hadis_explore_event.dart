part of 'hadis_explore_bloc.dart';

abstract class HadisExploreEvent extends Equatable {
  const HadisExploreEvent();

  @override
  List<Object> get props => [];
}

class LoadHadisExplore extends HadisExploreEvent {
  final bool isRefresh;
  const LoadHadisExplore({this.isRefresh = false});

  @override
  List<Object> get props => [isRefresh];
}

class LoadNextHadisExplore extends HadisExploreEvent {}

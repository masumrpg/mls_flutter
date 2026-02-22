part of 'hadis_search_bloc.dart';

abstract class HadisSearchEvent extends Equatable {
  const HadisSearchEvent();

  @override
  List<Object> get props => [];
}

class LoadHadisSearch extends HadisSearchEvent {
  final String query;
  const LoadHadisSearch(this.query);

  @override
  List<Object> get props => [query];
}

class LoadNextHadisSearch extends HadisSearchEvent {}

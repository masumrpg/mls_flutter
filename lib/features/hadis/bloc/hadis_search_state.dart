part of 'hadis_search_bloc.dart';

abstract class HadisSearchState extends Equatable {
  const HadisSearchState();

  @override
  List<Object> get props => [];
}

class HadisSearchInitial extends HadisSearchState {}

class HadisSearchLoading extends HadisSearchState {}

class HadisSearchLoaded extends HadisSearchState {
  final String query;
  final List<HadisModel> hadis;
  final bool hasReachedMax;
  final int currentPage;

  const HadisSearchLoaded({
    required this.query,
    required this.hadis,
    required this.hasReachedMax,
    required this.currentPage,
  });

  @override
  List<Object> get props => [query, hadis, hasReachedMax, currentPage];
}

class HadisSearchError extends HadisSearchState {
  final String message;

  const HadisSearchError(this.message);

  @override
  List<Object> get props => [message];
}

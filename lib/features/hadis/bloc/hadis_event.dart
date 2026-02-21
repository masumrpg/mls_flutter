part of 'hadis_bloc.dart';

abstract class HadisEvent extends Equatable {
  const HadisEvent();

  @override
  List<Object> get props => [];
}

class FetchHadisExplore extends HadisEvent {
  final int page;
  const FetchHadisExplore({this.page = 1});

  @override
  List<Object> get props => [page];
}

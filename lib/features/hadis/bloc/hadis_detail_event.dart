part of 'hadis_detail_bloc.dart';

abstract class HadisDetailEvent extends Equatable {
  const HadisDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadHadisDetail extends HadisDetailEvent {
  final int id;
  const LoadHadisDetail(this.id);

  @override
  List<Object> get props => [id];
}

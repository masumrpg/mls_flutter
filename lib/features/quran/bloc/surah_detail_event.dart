part of 'surah_detail_bloc.dart';

abstract class SurahDetailEvent extends Equatable {
  const SurahDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchSurahDetail extends SurahDetailEvent {
  final int surahNumber;

  const FetchSurahDetail(this.surahNumber);

  @override
  List<Object> get props => [surahNumber];
}

part of 'surah_detail_bloc.dart';

abstract class SurahDetailState extends Equatable {
  const SurahDetailState();

  @override
  List<Object> get props => [];
}

class SurahDetailInitial extends SurahDetailState {
  const SurahDetailInitial();
}

class SurahDetailLoading extends SurahDetailState {
  const SurahDetailLoading();
}

class SurahDetailLoaded extends SurahDetailState {
  final SurahDetailEntity surahDetail;

  const SurahDetailLoaded(this.surahDetail);

  @override
  List<Object> get props => [surahDetail];
}

class SurahDetailError extends SurahDetailState {
  final String message;

  const SurahDetailError(this.message);

  @override
  List<Object> get props => [message];
}

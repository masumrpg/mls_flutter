import 'package:equatable/equatable.dart';

abstract class ProfilEvent extends Equatable {
  const ProfilEvent();

  @override
  List<Object> get props => [];
}

class FetchProfilStats extends ProfilEvent {
  const FetchProfilStats();
}

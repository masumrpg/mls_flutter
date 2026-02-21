import 'package:equatable/equatable.dart';

abstract class KalenderEvent extends Equatable {
  const KalenderEvent();

  @override
  List<Object> get props => [];
}

class FetchKalenderToday extends KalenderEvent {
  const FetchKalenderToday();
}

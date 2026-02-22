import 'package:equatable/equatable.dart';

class KalenderEntity extends Equatable {
  final KalenderDateEntity ce;
  final KalenderDateEntity hijr;

  const KalenderEntity({required this.ce, required this.hijr});

  @override
  List<Object?> get props => [ce, hijr];
}

class KalenderDateEntity extends Equatable {
  final String today;
  final int day;
  final String dayName;
  final int month;
  final String monthName;
  final int year;

  const KalenderDateEntity({
    required this.today,
    required this.day,
    required this.dayName,
    required this.month,
    required this.monthName,
    required this.year,
  });

  @override
  List<Object?> get props => [today, day, dayName, month, monthName, year];
}

import '../../domain/entities/kalender_entity.dart';

class KalenderModel extends KalenderEntity {
  const KalenderModel({
    required super.ce,
    required super.hijr,
  });

  factory KalenderModel.fromJson(Map<String, dynamic> json) {
    return KalenderModel(
      ce: KalenderDateModel.fromJson(json['ce'] as Map<String, dynamic>),
      hijr: KalenderDateModel.fromJson(json['hijr'] as Map<String, dynamic>),
    );
  }
}

class KalenderDateModel extends KalenderDateEntity {
  const KalenderDateModel({
    required super.today,
    required super.day,
    required super.dayName,
    required super.month,
    required super.monthName,
    required super.year,
  });

  factory KalenderDateModel.fromJson(Map<String, dynamic> json) {
    return KalenderDateModel(
      today: json['today'] as String,
      day: json['day'] as int,
      dayName: json['dayName'] as String,
      month: json['month'] as int,
      monthName: json['monthName'] as String,
      year: json['year'] as int,
    );
  }
}

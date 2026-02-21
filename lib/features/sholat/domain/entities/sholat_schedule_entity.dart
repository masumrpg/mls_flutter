import 'package:equatable/equatable.dart';

class SholatScheduleEntity extends Equatable {
  final String cityId;
  final String cityName;
  final String province;
  final String date;
  final String imsak;
  final String subuh;
  final String terbit;
  final String dhuha;
  final String dzuhur;
  final String ashar;
  final String maghrib;
  final String isya;

  const SholatScheduleEntity({
    required this.cityId,
    required this.cityName,
    required this.province,
    required this.date,
    required this.imsak,
    required this.subuh,
    required this.terbit,
    required this.dhuha,
    required this.dzuhur,
    required this.ashar,
    required this.maghrib,
    required this.isya,
  });

  @override
  List<Object?> get props => [
    cityId,
    cityName,
    province,
    date,
    imsak,
    subuh,
    terbit,
    dhuha,
    dzuhur,
    ashar,
    maghrib,
    isya,
  ];
}

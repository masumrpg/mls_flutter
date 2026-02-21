import '../../domain/entities/sholat_schedule_entity.dart';

class SholatScheduleModel extends SholatScheduleEntity {
  const SholatScheduleModel({
    required super.cityId,
    required super.cityName,
    required super.province,
    required super.date,
    required super.imsak,
    required super.subuh,
    required super.terbit,
    required super.dhuha,
    required super.dzuhur,
    required super.ashar,
    required super.maghrib,
    required super.isya,
  });

  factory SholatScheduleModel.fromJson(Map<String, dynamic> json) {
    final jadwalStr = json['jadwal'] as Map<String, dynamic>;
    // The jadwal object actually contains a key that is the date format (e.g. "2026-02-21")
    // By getting the first value we avoid hardcoding the exact today string.
    final jadwal = jadwalStr.values.first as Map<String, dynamic>;

    return SholatScheduleModel(
      cityId: json['id'] as String,
      cityName: json['kabko'] as String,
      province: json['prov'] as String,
      date: jadwal['tanggal'] as String,
      imsak: jadwal['imsak'] as String,
      subuh: jadwal['subuh'] as String,
      terbit: jadwal['terbit'] as String,
      dhuha: jadwal['dhuha'] as String,
      dzuhur: jadwal['dzuhur'] as String,
      ashar: jadwal['ashar'] as String,
      maghrib: jadwal['maghrib'] as String,
      isya: jadwal['isya'] as String,
    );
  }
}

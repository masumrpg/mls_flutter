import '../../domain/entities/profil_entity.dart';

class ProfilModel extends ProfilEntity {
  const ProfilModel({
    required super.avg,
    required super.detail,
  });

  factory ProfilModel.fromJson(Map<String, dynamic> json) {
    return ProfilModel(
      avg: (json['avg'] as num).toDouble(),
      detail: (json['detail'] as List)
          .map((e) => ProfilDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ProfilDetailModel extends ProfilDetailEntity {
  const ProfilDetailModel({
    required super.tahun,
    required super.bulan,
    required super.hits,
  });

  factory ProfilDetailModel.fromJson(Map<String, dynamic> json) {
    return ProfilDetailModel(
      tahun: json['tahun'] as int,
      bulan: json['bulan'] as int,
      hits: json['hits'] as int,
    );
  }
}

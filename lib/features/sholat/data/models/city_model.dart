import '../../domain/entities/city_entity.dart';

class CityModel extends CityEntity {
  const CityModel({required super.id, required super.location});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] as String,
      location: json['lokasi'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'lokasi': location};
  }
}

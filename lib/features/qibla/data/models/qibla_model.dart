import '../../domain/entities/qibla_entity.dart';

class QiblaModel extends QiblaEntity {
  const QiblaModel({
    required super.latitude,
    required super.longitude,
    required super.direction,
  });

  factory QiblaModel.fromJson(Map<String, dynamic> json) {
    return QiblaModel(
      latitude: json['latitude'] as double? ?? 0.0,
      longitude: json['longitude'] as double? ?? 0.0,
      direction: json['direction'] as double? ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'direction': direction,
    };
  }

  QiblaEntity toEntity() {
    return QiblaEntity(
      latitude: latitude,
      longitude: longitude,
      direction: direction,
    );
  }
}

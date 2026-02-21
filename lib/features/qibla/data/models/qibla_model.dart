import '../../domain/entities/qibla_entity.dart';

class QiblaModel extends QiblaEntity {
  const QiblaModel({
    required super.id,
    required super.name,
  });

  factory QiblaModel.fromJson(Map<String, dynamic> json) {
    return QiblaModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  QiblaEntity toEntity() {
    return QiblaEntity(
      id: id,
      name: name,
    );
  }
}

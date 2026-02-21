import '../../domain/entities/sholat_entity.dart';

class SholatModel extends SholatEntity {
  const SholatModel({required super.id, required super.name});

  factory SholatModel.fromJson(Map<String, dynamic> json) {
    return SholatModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  SholatEntity toEntity() {
    return SholatEntity(id: id, name: name);
  }
}

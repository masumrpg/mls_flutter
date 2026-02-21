import '../../domain/entities/splash_entity.dart';

class SplashModel extends SplashEntity {
  const SplashModel({
    required super.id,
    required super.name,
  });

  factory SplashModel.fromJson(Map<String, dynamic> json) {
    return SplashModel(
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

  SplashEntity toEntity() {
    return SplashEntity(
      id: id,
      name: name,
    );
  }
}

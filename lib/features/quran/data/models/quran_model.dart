import '../../domain/entities/quran_entity.dart';

class SurahModel extends SurahEntity {
  const SurahModel({
    required super.number,
    required super.name,
    required super.nameLatin,
    required super.numberOfAyahs,
    required super.translation,
    required super.revelation,
    required super.description,
    required super.audioUrl,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) {
    return SurahModel(
      number: json['number'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      nameLatin: json['name_latin'] as String? ?? '',
      numberOfAyahs: json['number_of_ayahs'] as int? ?? 0,
      translation: json['translation'] as String? ?? '',
      revelation: json['revelation'] as String? ?? '',
      description: json['description'] as String? ?? '',
      audioUrl: json['audio_url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'name_latin': nameLatin,
      'number_of_ayahs': numberOfAyahs,
      'translation': translation,
      'revelation': revelation,
      'description': description,
      'audio_url': audioUrl,
    };
  }

  SurahEntity toEntity() {
    return SurahEntity(
      number: number,
      name: name,
      nameLatin: nameLatin,
      numberOfAyahs: numberOfAyahs,
      translation: translation,
      revelation: revelation,
      description: description,
      audioUrl: audioUrl,
    );
  }
}

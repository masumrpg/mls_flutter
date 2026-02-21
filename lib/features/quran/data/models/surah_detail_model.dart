import '../../domain/entities/surah_detail_entity.dart';

class AyahModel extends AyahEntity {
  const AyahModel({
    required super.id,
    required super.surahNumber,
    required super.ayahNumber,
    required super.arab,
    required super.translation,
    super.audioUrl,
    super.imageUrl,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      id: json['id'] as int? ?? 0,
      surahNumber: json['surah_number'] as int? ?? 0,
      ayahNumber: json['ayah_number'] as int? ?? 0,
      arab: json['arab'] as String? ?? '',
      translation: json['translation'] as String? ?? '',
      audioUrl: json['audio_url'] as String?,
      imageUrl: json['image_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'surah_number': surahNumber,
      'ayah_number': ayahNumber,
      'arab': arab,
      'translation': translation,
      'audio_url': audioUrl,
      'image_url': imageUrl,
    };
  }

  AyahEntity toEntity() {
    return AyahEntity(
      id: id,
      surahNumber: surahNumber,
      ayahNumber: ayahNumber,
      arab: arab,
      translation: translation,
      audioUrl: audioUrl,
      imageUrl: imageUrl,
    );
  }
}

class SurahDetailModel extends SurahDetailEntity {
  const SurahDetailModel({
    required super.number,
    required super.name,
    required super.nameLatin,
    required super.numberOfAyahs,
    required super.translation,
    required super.revelation,
    required super.description,
    required super.audioUrl,
    required super.ayahs,
  });

  factory SurahDetailModel.fromJson(Map<String, dynamic> json) {
    var ayahsList = json['ayahs'] as List<dynamic>? ?? [];
    List<AyahModel> ayahs = ayahsList
        .map((i) => AyahModel.fromJson(i as Map<String, dynamic>))
        .toList();

    return SurahDetailModel(
      number: json['number'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      nameLatin: json['name_latin'] as String? ?? '',
      numberOfAyahs: json['number_of_ayahs'] as int? ?? 0,
      translation: json['translation'] as String? ?? '',
      revelation: json['revelation'] as String? ?? '',
      description: json['description'] as String? ?? '',
      audioUrl: json['audio_url'] as String? ?? '',
      ayahs: ayahs,
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
      'ayahs': ayahs.map((a) => (a as AyahModel).toJson()).toList(),
    };
  }

  SurahDetailEntity toEntity() {
    return SurahDetailEntity(
      number: number,
      name: name,
      nameLatin: nameLatin,
      numberOfAyahs: numberOfAyahs,
      translation: translation,
      revelation: revelation,
      description: description,
      audioUrl: audioUrl,
      ayahs: ayahs.map((a) => (a as AyahModel).toEntity()).toList(),
    );
  }
}

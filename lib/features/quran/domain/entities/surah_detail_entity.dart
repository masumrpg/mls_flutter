import 'package:equatable/equatable.dart';

class AyahEntity extends Equatable {
  final int id;
  final int surahNumber;
  final int ayahNumber;
  final String arab;
  final String translation;
  final String? audioUrl;
  final String? imageUrl;

  const AyahEntity({
    required this.id,
    required this.surahNumber,
    required this.ayahNumber,
    required this.arab,
    required this.translation,
    this.audioUrl,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        surahNumber,
        ayahNumber,
        arab,
        translation,
        audioUrl,
        imageUrl,
      ];
}

class SurahDetailEntity extends Equatable {
  final int number;
  final String name;
  final String nameLatin;
  final int numberOfAyahs;
  final String translation;
  final String revelation;
  final String description;
  final String audioUrl;
  final List<AyahEntity> ayahs;

  const SurahDetailEntity({
    required this.number,
    required this.name,
    required this.nameLatin,
    required this.numberOfAyahs,
    required this.translation,
    required this.revelation,
    required this.description,
    required this.audioUrl,
    required this.ayahs,
  });

  @override
  List<Object?> get props => [
        number,
        name,
        nameLatin,
        numberOfAyahs,
        translation,
        revelation,
        description,
        audioUrl,
        ayahs,
      ];
}

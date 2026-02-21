import 'package:equatable/equatable.dart';

class SurahEntity extends Equatable {
  final int number;
  final String name;
  final String nameLatin;
  final int numberOfAyahs;
  final String translation;
  final String revelation;
  final String description;
  final String audioUrl;

  const SurahEntity({
    required this.number,
    required this.name,
    required this.nameLatin,
    required this.numberOfAyahs,
    required this.translation,
    required this.revelation,
    required this.description,
    required this.audioUrl,
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
      ];
}

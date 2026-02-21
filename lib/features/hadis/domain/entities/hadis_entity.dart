import 'package:equatable/equatable.dart';

class HadisTextEntity extends Equatable {
  final String ar;
  final String id;

  const HadisTextEntity({
    required this.ar,
    required this.id,
  });

  @override
  List<Object?> get props => [ar, id];
}

class HadisEntryEntity extends Equatable {
  final int id;
  final HadisTextEntity text;
  final String? grade;
  final String? takhrij;
  final String? hikmah;

  const HadisEntryEntity({
    required this.id,
    required this.text,
    this.grade,
    this.takhrij,
    this.hikmah,
  });

  @override
  List<Object?> get props => [id, text, grade, takhrij, hikmah];
}

class HadisPagingEntity extends Equatable {
  final int current;
  final int perPage;
  final int totalData;
  final int totalPages;
  final bool hasPrev;
  final bool hasNext;
  final int? nextPage;
  final int? prevPage;
  final int? firstPage;
  final int? lastPage;

  const HadisPagingEntity({
    required this.current,
    required this.perPage,
    required this.totalData,
    required this.totalPages,
    required this.hasPrev,
    required this.hasNext,
    this.nextPage,
    this.prevPage,
    this.firstPage,
    this.lastPage,
  });

  @override
  List<Object?> get props => [
        current,
        perPage,
        totalData,
        totalPages,
        hasPrev,
        hasNext,
        nextPage,
        prevPage,
        firstPage,
        lastPage,
      ];
}

class HadisExploreEntity extends Equatable {
  final HadisPagingEntity paging;
  final List<HadisEntryEntity> hadis;

  const HadisExploreEntity({
    required this.paging,
    required this.hadis,
  });

  @override
  List<Object?> get props => [paging, hadis];
}

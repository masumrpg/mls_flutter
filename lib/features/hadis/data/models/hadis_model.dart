import '../../domain/entities/hadis_entity.dart';

class HadisTextModel extends HadisTextEntity {
  const HadisTextModel({
    required super.ar,
    required super.id,
  });

  factory HadisTextModel.fromJson(Map<String, dynamic> json) {
    return HadisTextModel(
      ar: json['ar'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ar': ar,
      'id': id,
    };
  }

  HadisTextEntity toEntity() {
    return HadisTextEntity(ar: ar, id: id);
  }
}

class HadisEntryModel extends HadisEntryEntity {
  const HadisEntryModel({
    required super.id,
    required super.text,
    super.grade,
    super.takhrij,
    super.hikmah,
  });

  factory HadisEntryModel.fromJson(Map<String, dynamic> json) {
    return HadisEntryModel(
      id: json['id'] as int? ?? 0,
      text: HadisTextModel.fromJson(json['text'] as Map<String, dynamic>? ?? {}),
      grade: json['grade'] as String?,
      takhrij: json['takhrij'] as String?,
      hikmah: json['hikmah'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': (text as HadisTextModel).toJson(),
      'grade': grade,
      'takhrij': takhrij,
      'hikmah': hikmah,
    };
  }

  HadisEntryEntity toEntity() {
    return HadisEntryEntity(
      id: id,
      text: (text as HadisTextModel).toEntity(),
      grade: grade,
      takhrij: takhrij,
      hikmah: hikmah,
    );
  }
}

class HadisPagingModel extends HadisPagingEntity {
  const HadisPagingModel({
    required super.current,
    required super.perPage,
    required super.totalData,
    required super.totalPages,
    required super.hasPrev,
    required super.hasNext,
    super.nextPage,
    super.prevPage,
    super.firstPage,
    super.lastPage,
  });

  factory HadisPagingModel.fromJson(Map<String, dynamic> json) {
    return HadisPagingModel(
      current: json['current'] as int? ?? 1,
      perPage: json['per_page'] as int? ?? 0,
      totalData: json['total_data'] as int? ?? 0,
      totalPages: json['total_pages'] as int? ?? 0,
      hasPrev: json['has_prev'] as bool? ?? false,
      hasNext: json['has_next'] as bool? ?? false,
      nextPage: json['next_page'] as int?,
      prevPage: json['prev_page'] as int?,
      firstPage: json['first_page'] as int?,
      lastPage: json['last_page'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current': current,
      'per_page': perPage,
      'total_data': totalData,
      'total_pages': totalPages,
      'has_prev': hasPrev,
      'has_next': hasNext,
      'next_page': nextPage,
      'prev_page': prevPage,
      'first_page': firstPage,
      'last_page': lastPage,
    };
  }

  HadisPagingEntity toEntity() {
    return HadisPagingEntity(
      current: current,
      perPage: perPage,
      totalData: totalData,
      totalPages: totalPages,
      hasPrev: hasPrev,
      hasNext: hasNext,
      nextPage: nextPage,
      prevPage: prevPage,
      firstPage: firstPage,
      lastPage: lastPage,
    );
  }
}

class HadisExploreModel extends HadisExploreEntity {
  const HadisExploreModel({
    required super.paging,
    required super.hadis,
  });

  factory HadisExploreModel.fromJson(Map<String, dynamic> json) {
    var hadisList = json['hadis'] as List<dynamic>? ?? [];
    return HadisExploreModel(
      paging: HadisPagingModel.fromJson(json['paging'] as Map<String, dynamic>? ?? {}),
      hadis: hadisList.map((i) => HadisEntryModel.fromJson(i as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paging': (paging as HadisPagingModel).toJson(),
      'hadis': hadis.map((h) => (h as HadisEntryModel).toJson()).toList(),
    };
  }

  HadisExploreEntity toEntity() {
    return HadisExploreEntity(
      paging: (paging as HadisPagingModel).toEntity(),
      hadis: hadis.map((h) => (h as HadisEntryModel).toEntity()).toList(),
    );
  }
}

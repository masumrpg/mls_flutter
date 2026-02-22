class HadisModel {
  final int id;
  final String textAr;
  final String textId;
  final String? grade;
  final String? takhrij;
  final String? hikmah;

  HadisModel({
    required this.id,
    required this.textAr,
    required this.textId,
    this.grade,
    this.takhrij,
    this.hikmah,
  });

  factory HadisModel.fromJson(Map<String, dynamic> json) {
    String ar = '';
    String id = '';

    final textNode = json['text'];
    if (textNode is Map) {
      ar = textNode['ar']?.toString() ?? '';
      id = textNode['id']?.toString() ?? '';
    } else if (textNode is String) {
      id = textNode;
    }

    return HadisModel(
      id: json['id'] as int? ?? 0,
      textAr: ar,
      textId: id,
      grade: json['grade'] as String?,
      takhrij: json['takhrij'] as String?,
      hikmah: json['hikmah'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': {'ar': textAr, 'id': textId},
      'grade': grade,
      'takhrij': takhrij,
      'hikmah': hikmah,
    };
  }
}

class HadisPagingModel {
  final int current;
  final int perPage;
  final int totalData;
  final int totalPages;
  final bool hasNext;

  HadisPagingModel({
    required this.current,
    required this.perPage,
    required this.totalData,
    required this.totalPages,
    required this.hasNext,
  });

  factory HadisPagingModel.fromJson(Map<String, dynamic> json) {
    return HadisPagingModel(
      current: json['current'] as int? ?? 1,
      perPage: json['per_page'] as int? ?? 10,
      totalData: json['total_data'] as int? ?? 0,
      totalPages: json['total_pages'] as int? ?? 0,
      hasNext: json['has_next'] as bool? ?? false,
    );
  }
}

class HadisResponseModel {
  final HadisPagingModel? paging;
  final List<HadisModel> hadis;

  HadisResponseModel({this.paging, this.hadis = const [],
  });

  factory HadisResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;
    if (data == null) {
      return HadisResponseModel();
    }

    // Check if it's explore/search (returns hadis list) or show (returns single hadis)
    bool isList = data.containsKey('hadis');

    if (isList) {
      final items =
          (data['hadis'] as List?)
              ?.map((e) => HadisModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
      final paging = data['paging'] != null
          ? HadisPagingModel.fromJson(data['paging'] as Map<String, dynamic>)
          : null;
      return HadisResponseModel(paging: paging, hadis: items);
    } else {
      // It's a single detail show response
      return HadisResponseModel(hadis: [HadisModel.fromJson(data)]);
    }
  }
}

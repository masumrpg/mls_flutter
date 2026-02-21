import '../../../../core/network/api_client.dart';
import '../../../../core/error/exception.dart';
import '../models/quran_model.dart';
// import 'package:dio/dio.dart'; // Uncomment if needed

import '../models/surah_detail_model.dart';

abstract class QuranRemoteDataSource {
  Future<List<SurahModel>> getSurahs();
  Future<SurahDetailModel> getSurahDetail(int surahNumber);
}

class QuranRemoteDataSourceImpl implements QuranRemoteDataSource {
  final ApiClient apiClient;

  QuranRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<SurahModel>> getSurahs() async {
    try {
      final response = await apiClient.get('/quran');
      final List<dynamic> data = response.data['data'] as List<dynamic>;
      return data.map((json) => SurahModel.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ServerException('Failed to fetch surahs: $e');
    }
  }

  @override
  Future<SurahDetailModel> getSurahDetail(int surahNumber) async {
    try {
      final response = await apiClient.get('/quran/$surahNumber');
      final data = response.data['data'] as Map<String, dynamic>;
      return SurahDetailModel.fromJson(data);
    } catch (e) {
      throw ServerException('Failed to fetch surah detail: $e');
    }
  }
}

import '../../../../core/network/api_client.dart';
import '../../../../core/error/exception.dart';
import '../models/quran_model.dart';
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
      int page = 1;
      const int limit = 100;
      bool hasMore = true;

      Map<String, dynamic>? baseData;
      List<dynamic> allAyahs = [];

      while (hasMore) {
        final response = await apiClient.get(
          '/quran/$surahNumber',
          queryParameters: {'limit': limit, 'page': page},
        );

        final data = response.data['data'] as Map<String, dynamic>;

        // Clone the base structure from the first page
        baseData ??= Map<String, dynamic>.from(data);

        // Add ayahs from current page
        final ayahs = data['ayahs'] as List<dynamic>;
        allAyahs.addAll(ayahs);

        // Check pagination if present
        final pagination = response.data['pagination'];
        if (pagination != null) {
          final total = pagination['total'] as int;
          if (page * limit >= total) {
            hasMore = false;
          } else {
            page++;
          }
        } else {
          // If no pagination metadata, assume it's complete
          hasMore = false;
        }
      }

      // Re-assign the aggregated ayahs into the base payload
      baseData!['ayahs'] = allAyahs;

      return SurahDetailModel.fromJson(baseData);
    } catch (e) {
      throw ServerException('Failed to fetch surah detail: $e');
    }
  }
}

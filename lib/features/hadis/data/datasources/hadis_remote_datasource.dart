import '../../../../core/network/api_client.dart';
import '../../../../core/error/exception.dart';
import '../models/hadis_model.dart';

abstract class HadisRemoteDataSource {
  Future<HadisExploreModel> exploreHadis({int page = 1, int limit = 10});
}

class HadisRemoteDataSourceImpl implements HadisRemoteDataSource {
  final ApiClient apiClient;

  HadisRemoteDataSourceImpl(this.apiClient);

  @override
  Future<HadisExploreModel> exploreHadis({int page = 1, int limit = 10}) async {
    try {
      final response = await apiClient.get('/hadis/enc/explore', queryParameters: {
        'page': page,
        'limit': limit,
      });
      final data = response.data['data'] as Map<String, dynamic>;
      return HadisExploreModel.fromJson(data);
    } catch (e) {
      throw ServerException('Failed to fetch hadis: $e');
    }
  }
}

import '../../../../core/network/api_client.dart';
import '../../../../core/error/exception.dart';
import '../models/profil_model.dart';

abstract class ProfilRemoteDataSource {
  Future<ProfilModel> getProfilStats();
}

class ProfilRemoteDataSourceImpl implements ProfilRemoteDataSource {
  final ApiClient apiClient;

  ProfilRemoteDataSourceImpl(this.apiClient);

  @override
  Future<ProfilModel> getProfilStats() async {
    try {
      final response = await apiClient.get('/stats');
      final data = response.data['data'] as Map<String, dynamic>;
      return ProfilModel.fromJson(data);
    } catch (e) {
      throw ServerException('Failed to fetch profile stats: $e');
    }
  }
}

import '../../../../core/network/api_client.dart';
import '../../../../core/error/exception.dart';
import '../models/qibla_model.dart';

abstract class QiblaRemoteDataSource {
  Future<QiblaModel> getQibla(double latitude, double longitude);
}

class QiblaRemoteDataSourceImpl implements QiblaRemoteDataSource {
  final ApiClient apiClient;

  QiblaRemoteDataSourceImpl(this.apiClient);

  @override
  Future<QiblaModel> getQibla(double latitude, double longitude) async {
    try {
      final response = await apiClient.get('/qibla/$latitude,$longitude');
      final data = response.data['data'] as Map<String, dynamic>;
      // API Muslim v3 returns latitude and longitude as string sometimes, or numbers.
      // Easiest is to let our model parse it.
      return QiblaModel.fromJson(data);
    } catch (e) {
      throw ServerException('Failed to fetch qibla direction: $e');
    }
  }
}

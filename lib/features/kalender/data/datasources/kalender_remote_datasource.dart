import '../../../../core/network/api_client.dart';
import '../../../../core/error/exception.dart';
import '../models/kalender_model.dart';

abstract class KalenderRemoteDataSource {
  Future<KalenderModel> getKalenderToday();
}

class KalenderRemoteDataSourceImpl implements KalenderRemoteDataSource {
  final ApiClient apiClient;

  KalenderRemoteDataSourceImpl(this.apiClient);

  @override
  Future<KalenderModel> getKalenderToday() async {
    try {
      final response = await apiClient.get('/cal/today');
      final data = response.data['data'] as Map<String, dynamic>;
      return KalenderModel.fromJson(data);
    } catch (e) {
      throw ServerException("Failed to fetch today's calendar: $e");
    }
  }
}

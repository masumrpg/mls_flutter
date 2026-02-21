import '../../../../core/network/api_client.dart';
import '../../../../core/error/exception.dart';
import '../models/qibla_model.dart';
// import 'package:dio/dio.dart'; // Uncomment if needed

abstract class QiblaRemoteDataSource {
  Future<List<QiblaModel>> getItems();
  Future<QiblaModel> getItemById(String id);
}

class QiblaRemoteDataSourceImpl implements QiblaRemoteDataSource {
  final ApiClient apiClient;

  QiblaRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<QiblaModel>> getItems() async {
    try {
      // Example call
      // final response = await apiClient.get('/qibla');
      // final List<dynamic> data = response.data as List<dynamic>;
      // return data.map((json) => ${featureClass}Model.fromJson(json as Map<String, dynamic>)).toList();

      // Mock data
      await Future.delayed(const Duration(seconds: 1));
      return [
        const QiblaModel(id: '1', name: 'Item 1'),
        const QiblaModel(id: '2', name: 'Item 2'),
      ];
    } catch (e) {
      throw ServerException('Failed to fetch items: $e');
    }
  }

  @override
  Future<QiblaModel> getItemById(String id) async {
    try {
      // Example call
      // final response = await apiClient.get('/$feature/$id');
      // return ${featureClass}Model.fromJson(response.data as Map<String, dynamic>);

      // Mock data
      await Future.delayed(const Duration(milliseconds: 500));
      return QiblaModel(id: id, name: 'Sample Item $id');
    } catch (e) {
      throw ServerException('Failed to fetch item: $e');
    }
  }
}

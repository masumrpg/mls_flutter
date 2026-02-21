import '../../../../core/network/api_client.dart';
import '../../../../core/error/exception.dart';
import '../models/splash_model.dart';
// import 'package:dio/dio.dart'; // Uncomment if needed

abstract class SplashRemoteDataSource {
  Future<List<SplashModel>> getItems();
  Future<SplashModel> getItemById(String id);
}

class SplashRemoteDataSourceImpl implements SplashRemoteDataSource {
  final ApiClient apiClient;

  SplashRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<SplashModel>> getItems() async {
    try {
      // Example call
      // final response = await apiClient.get('/splash');
      // final List<dynamic> data = response.data as List<dynamic>;
      // return data.map((json) => ${featureClass}Model.fromJson(json as Map<String, dynamic>)).toList();

      // Mock data
      await Future.delayed(const Duration(seconds: 1));
      return [
        const SplashModel(id: '1', name: 'Item 1'),
        const SplashModel(id: '2', name: 'Item 2'),
      ];
    } catch (e) {
      throw ServerException('Failed to fetch items: $e');
    }
  }

  @override
  Future<SplashModel> getItemById(String id) async {
    try {
      // Example call
      // final response = await apiClient.get('/$feature/$id');
      // return ${featureClass}Model.fromJson(response.data as Map<String, dynamic>);

      // Mock data
      await Future.delayed(const Duration(milliseconds: 500));
      return SplashModel(id: id, name: 'Sample Item $id');
    } catch (e) {
      throw ServerException('Failed to fetch item: $e');
    }
  }
}

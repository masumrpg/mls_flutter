import '../../../../core/network/api_client.dart';
import '../../../../core/error/exception.dart';
import '../models/dashboard_model.dart';
// import 'package:dio/dio.dart'; // Uncomment if needed

abstract class DashboardRemoteDataSource {
  Future<List<DashboardModel>> getItems();
  Future<DashboardModel> getItemById(String id);
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final ApiClient apiClient;

  DashboardRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<DashboardModel>> getItems() async {
    try {
      // Example call
      // final response = await apiClient.get('/dashboard');
      // final List<dynamic> data = response.data as List<dynamic>;
      // return data.map((json) => ${featureClass}Model.fromJson(json as Map<String, dynamic>)).toList();

      // Mock data
      await Future.delayed(const Duration(seconds: 1));
      return [
        const DashboardModel(id: '1', name: 'Item 1'),
        const DashboardModel(id: '2', name: 'Item 2'),
      ];
    } catch (e) {
      throw ServerException('Failed to fetch items: $e');
    }
  }

  @override
  Future<DashboardModel> getItemById(String id) async {
    try {
      // Example call
      // final response = await apiClient.get('/$feature/$id');
      // return ${featureClass}Model.fromJson(response.data as Map<String, dynamic>);

      // Mock data
      await Future.delayed(const Duration(milliseconds: 500));
      return DashboardModel(id: id, name: 'Sample Item $id');
    } catch (e) {
      throw ServerException('Failed to fetch item: $e');
    }
  }
}

import '../../../../core/network/api_client.dart';
import '../../../../core/error/exception.dart';
import '../models/home_model.dart';
// import 'package:dio/dio.dart'; // Uncomment if needed

abstract class HomeRemoteDataSource {
  Future<List<HomeModel>> getItems();
  Future<HomeModel> getItemById(String id);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient apiClient;

  HomeRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<HomeModel>> getItems() async {
    try {
      // Example call
      // final response = await apiClient.get('/home');
      // final List<dynamic> data = response.data as List<dynamic>;
      // return data.map((json) => ${featureClass}Model.fromJson(json as Map<String, dynamic>)).toList();

      // Mock data
      await Future.delayed(const Duration(seconds: 1));
      return [
        const HomeModel(id: '1', name: 'Item 1'),
        const HomeModel(id: '2', name: 'Item 2'),
      ];
    } catch (e) {
      throw ServerException('Failed to fetch items: $e');
    }
  }

  @override
  Future<HomeModel> getItemById(String id) async {
    try {
      // Example call
      // final response = await apiClient.get('/$feature/$id');
      // return ${featureClass}Model.fromJson(response.data as Map<String, dynamic>);

      // Mock data
      await Future.delayed(const Duration(milliseconds: 500));
      return HomeModel(id: id, name: 'Sample Item $id');
    } catch (e) {
      throw ServerException('Failed to fetch item: $e');
    }
  }
}

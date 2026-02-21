import '../../../../core/network/api_client.dart';
import '../../../../core/error/exception.dart';
import '../models/auth_model.dart';
// import 'package:dio/dio.dart'; // Uncomment if needed

abstract class AuthRemoteDataSource {
  Future<List<AuthModel>> getItems();
  Future<AuthModel> getItemById(String id);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<AuthModel>> getItems() async {
    try {
      // Example call
      // final response = await apiClient.get('/auth');
      // final List<dynamic> data = response.data as List<dynamic>;
      // return data.map((json) => ${featureClass}Model.fromJson(json as Map<String, dynamic>)).toList();

      // Mock data
      await Future.delayed(const Duration(seconds: 1));
      return [
        const AuthModel(id: '1', name: 'Item 1'),
        const AuthModel(id: '2', name: 'Item 2'),
      ];
    } catch (e) {
      throw ServerException('Failed to fetch items: $e');
    }
  }

  @override
  Future<AuthModel> getItemById(String id) async {
    try {
      // Example call
      // final response = await apiClient.get('/$feature/$id');
      // return ${featureClass}Model.fromJson(response.data as Map<String, dynamic>);

      // Mock data
      await Future.delayed(const Duration(milliseconds: 500));
      return AuthModel(id: id, name: 'Sample Item $id');
    } catch (e) {
      throw ServerException('Failed to fetch item: $e');
    }
  }
}

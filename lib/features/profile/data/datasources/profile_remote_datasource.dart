import '../../../../core/network/api_client.dart';
import '../../../../core/error/exception.dart';
import '../models/profile_model.dart';
// import 'package:dio/dio.dart'; // Uncomment if needed

abstract class ProfileRemoteDataSource {
  Future<List<ProfileModel>> getItems();
  Future<ProfileModel> getItemById(String id);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient apiClient;

  ProfileRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<ProfileModel>> getItems() async {
    try {
      // Example call
      // final response = await apiClient.get('/profile');
      // final List<dynamic> data = response.data as List<dynamic>;
      // return data.map((json) => ${featureClass}Model.fromJson(json as Map<String, dynamic>)).toList();

      // Mock data
      await Future.delayed(const Duration(seconds: 1));
      return [
        const ProfileModel(id: '1', name: 'Item 1'),
        const ProfileModel(id: '2', name: 'Item 2'),
      ];
    } catch (e) {
      throw ServerException('Failed to fetch items: $e');
    }
  }

  @override
  Future<ProfileModel> getItemById(String id) async {
    try {
      // Example call
      // final response = await apiClient.get('/$feature/$id');
      // return ${featureClass}Model.fromJson(response.data as Map<String, dynamic>);

      // Mock data
      await Future.delayed(const Duration(milliseconds: 500));
      return ProfileModel(id: id, name: 'Sample Item $id');
    } catch (e) {
      throw ServerException('Failed to fetch item: $e');
    }
  }
}

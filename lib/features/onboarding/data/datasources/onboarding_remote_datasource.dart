import '../../../../core/network/api_client.dart';
import '../../../../core/error/exception.dart';
import '../models/onboarding_model.dart';
// import 'package:dio/dio.dart'; // Uncomment if needed

abstract class OnboardingRemoteDataSource {
  Future<List<OnboardingModel>> getItems();
  Future<OnboardingModel> getItemById(String id);
}

class OnboardingRemoteDataSourceImpl implements OnboardingRemoteDataSource {
  final ApiClient apiClient;

  OnboardingRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<OnboardingModel>> getItems() async {
    try {
      // Example call
      // final response = await apiClient.get('/onboarding');
      // final List<dynamic> data = response.data as List<dynamic>;
      // return data.map((json) => ${featureClass}Model.fromJson(json as Map<String, dynamic>)).toList();

      // Mock data
      await Future.delayed(const Duration(seconds: 1));
      return [
        const OnboardingModel(id: '1', name: 'Item 1'),
        const OnboardingModel(id: '2', name: 'Item 2'),
      ];
    } catch (e) {
      throw ServerException('Failed to fetch items: $e');
    }
  }

  @override
  Future<OnboardingModel> getItemById(String id) async {
    try {
      // Example call
      // final response = await apiClient.get('/$feature/$id');
      // return ${featureClass}Model.fromJson(response.data as Map<String, dynamic>);

      // Mock data
      await Future.delayed(const Duration(milliseconds: 500));
      return OnboardingModel(id: id, name: 'Sample Item $id');
    } catch (e) {
      throw ServerException('Failed to fetch item: $e');
    }
  }
}

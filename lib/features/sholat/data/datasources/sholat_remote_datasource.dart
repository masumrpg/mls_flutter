import '../../../../core/network/api_client.dart';
import '../../../../core/error/exception.dart';
import '../models/city_model.dart';
import '../models/sholat_schedule_model.dart';

abstract class SholatRemoteDataSource {
  Future<List<CityModel>> getCities();
  Future<List<CityModel>> searchCities(String keyword);
  Future<SholatScheduleModel> getScheduleToday(String cityId);
  Future<SholatScheduleModel> getSchedule(String cityId, String date);
}

class SholatRemoteDataSourceImpl implements SholatRemoteDataSource {
  final ApiClient apiClient;

  SholatRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<CityModel>> getCities() async {
    try {
      final response = await apiClient.get('/sholat/kabkota/semua');
      final data = response.data['data'] as List<dynamic>;
      return data.map((json) => CityModel.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ServerException('Failed to fetch cities: $e');
    }
  }

  @override
  Future<List<CityModel>> searchCities(String keyword) async {
    try {
      final response = await apiClient.get('/sholat/kabkota/cari/$keyword');
      final data = response.data['data'] as List<dynamic>;
      return data.map((json) => CityModel.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ServerException('Failed to search cities: $e');
    }
  }

  @override
  Future<SholatScheduleModel> getScheduleToday(String cityId) async {
    try {
      final response = await apiClient.get('/sholat/jadwal/$cityId/today');
      final data = response.data['data'] as Map<String, dynamic>;
      return SholatScheduleModel.fromJson(data);
    } catch (e) {
      throw ServerException("Failed to fetch today's schedule: $e");
    }
  }

  @override
  Future<SholatScheduleModel> getSchedule(String cityId, String date) async {
    try {
      final response = await apiClient.get('/sholat/jadwal/$cityId/$date');
      final data = response.data['data'] as Map<String, dynamic>;
      return SholatScheduleModel.fromJson(data);
    } catch (e) {
      throw ServerException('Failed to fetch schedule: $e');
    }
  }
}

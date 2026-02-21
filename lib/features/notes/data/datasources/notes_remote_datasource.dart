import '../../../../core/network/api_client.dart';
import '../models/notes_model.dart';

abstract class NotesRemoteDataSource {
  Future<List<NotesModel>> fetchAll();
  Future<NotesModel> create(NotesModel item);
  Future<NotesModel> update(NotesModel item);
  Future<void> delete(String id);
}

class NotesRemoteDataSourceImpl implements NotesRemoteDataSource {
  final ApiClient apiClient;

  NotesRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<NotesModel>> fetchAll() async {
    // TODO: Replace with your actual API endpoint
    final response = await apiClient.get('/notes');
    final List<dynamic> data = response.data as List<dynamic>;
    return data
        .map((json) =>
            NotesModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<NotesModel> create(NotesModel item) async {
    final response = await apiClient.post(
      '/notes',
      data: item.toJson(),
    );
    return NotesModel.fromJson(
        response.data as Map<String, dynamic>);
  }

  @override
  Future<NotesModel> update(NotesModel item) async {
    final response = await apiClient.put(
      '/notes/${item.id}',
      data: item.toJson(),
    );
    return NotesModel.fromJson(
        response.data as Map<String, dynamic>);
  }

  @override
  Future<void> delete(String id) async {
    await apiClient.delete('/notes/$id');
  }
}

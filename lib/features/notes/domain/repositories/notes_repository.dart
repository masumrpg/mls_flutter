import '../../data/models/notes_model.dart';

abstract class NotesRepository {
  /// Watch all items reactively from local DB
  Stream<List<NotesModel>> watchAll();

  /// Add a new item (local first, then sync)
  Future<void> add(NotesModel item);

  /// Update an item (local first, then sync)
  Future<void> update(NotesModel item);

  /// Delete an item
  Future<void> delete(String id);

  /// Sync all pending changes to remote
  Future<void> syncPendingChanges();
}

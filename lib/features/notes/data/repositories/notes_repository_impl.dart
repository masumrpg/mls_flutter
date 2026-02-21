import 'package:connectivity_plus/connectivity_plus.dart';
import '../../domain/repositories/notes_repository.dart';
import '../datasources/notes_local_datasource.dart';
import '../datasources/notes_remote_datasource.dart';
import '../models/notes_model.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesLocalDatasource localDatasource;
  final NotesRemoteDataSource remoteDatasource;
  final Connectivity connectivity;

  NotesRepositoryImpl({
    required this.localDatasource,
    required this.remoteDatasource,
    required this.connectivity,
  });

  Future<bool> get _isOnline async {
    final result = await connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

  @override
  Stream<List<NotesModel>> watchAll() {
    return localDatasource.watchAll().map(
          (items) =>
              items.map((e) => NotesModel.fromDrift(e)).toList(),
        );
  }

  @override
  Future<void> add(NotesModel item) async {
    // 1. Save to local DB first (isSynced: false)
    final localItem = item.copyWith(isSynced: false);
    await localDatasource.upsert(localItem.toDriftCompanion());

    // 2. Try to sync to remote if online
    if (await _isOnline) {
      try {
        await remoteDatasource.create(item);
        await localDatasource.markSynced(item.id);
      } catch (_) {
        // Failed to sync — will be retried later
      }
    }
  }

  @override
  Future<void> update(NotesModel item) async {
    // 1. Update locally first
    final localItem = item.copyWith(
      isSynced: false,
      updatedAt: DateTime.now(),
    );
    await localDatasource.upsert(localItem.toDriftCompanion());

    // 2. Try to sync to remote if online
    if (await _isOnline) {
      try {
        await remoteDatasource.update(item);
        await localDatasource.markSynced(item.id);
      } catch (_) {
        // Failed to sync — will be retried later
      }
    }
  }

  @override
  Future<void> delete(String id) async {
    // 1. Delete locally
    await localDatasource.deleteItem(id);

    // 2. Try to delete from remote if online
    if (await _isOnline) {
      try {
        await remoteDatasource.delete(id);
      } catch (_) {
        // TODO: Queue delete for later sync
      }
    }
  }

  @override
  Future<void> syncPendingChanges() async {
    if (!await _isOnline) return;

    final unsyncedItems = await localDatasource.getUnsynced();
    for (final item in unsyncedItems) {
      try {
        final model = NotesModel.fromDrift(item);
        // Strategy: push to remote, server wins on conflict
        await remoteDatasource.update(model);
        await localDatasource.markSynced(item.id);
      } catch (_) {
        // Skip failed items, retry on next sync
        continue;
      }
    }
  }
}

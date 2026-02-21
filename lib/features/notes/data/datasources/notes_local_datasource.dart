import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';

// ─── Table Definition ────────────────────────────────────────────────────────

class NotesItems extends Table {
  TextColumn get id => text()();
  TextColumn get title => text().withLength(min: 1, max: 255)();
  TextColumn get description => text().withDefault(const Constant(''))();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// ─── DAO (Data Access Object) ────────────────────────────────────────────────

class NotesLocalDatasource {
  final AppDatabase _db;

  NotesLocalDatasource(this._db);

  // Watch all items as a stream (reactive)
  Stream<List<NotesItem>> watchAll() {
    return (_db.select(_db.notesItems)
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.updatedAt,
                  mode: OrderingMode.desc,
                ),
          ]))
        .watch();
  }

  // Get all unsynced items
  Future<List<NotesItem>> getUnsynced() {
    return (_db.select(_db.notesItems)
          ..where((t) => t.isSynced.equals(false)))
        .get();
  }

  // Upsert (insert or update)
  Future<void> upsert(NotesItemsCompanion entry) {
    return _db
        .into(_db.notesItems)
        .insertOnConflictUpdate(entry);
  }

  // Mark as synced
  Future<void> markSynced(String id) {
    return (_db.update(_db.notesItems)
          ..where((t) => t.id.equals(id)))
        .write(
      const NotesItemsCompanion(
        isSynced: Value(true),
      ),
    );
  }

  // Delete
  Future<void> deleteItem(String id) {
    return (_db.delete(_db.notesItems)
          ..where((t) => t.id.equals(id)))
        .go();
  }
}

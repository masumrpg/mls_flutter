import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

// Import tables here
import '../../features/notes/data/datasources/notes_local_datasource.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [NotesItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase._() : super(_openConnection());

  static final AppDatabase instance = AppDatabase._();

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'app_database');
  }
}

import 'package:drift/drift.dart';

class ApiCacheTable extends Table {
  TextColumn get endpoint => text()();
  TextColumn get responseBody => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {endpoint};
}

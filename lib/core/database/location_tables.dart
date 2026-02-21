import 'package:drift/drift.dart';

class LocationCacheTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  TextColumn get cityName => text()();
  DateTimeColumn get updatedAt => dateTime()();
}

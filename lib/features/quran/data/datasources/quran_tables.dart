import 'package:drift/drift.dart';

class SurahsTable extends Table {
  IntColumn get number => integer()();
  TextColumn get name => text()();
  TextColumn get nameLatin => text()();
  IntColumn get numberOfAyahs => integer()();
  TextColumn get translation => text()();
  TextColumn get revelation => text()();
  TextColumn get description => text()();
  TextColumn get audioUrl => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {number};
}

class AyahsTable extends Table {
  IntColumn get id => integer()();
  IntColumn get surahNumber => integer()();
  IntColumn get ayahNumber => integer()();
  TextColumn get arab => text()();
  TextColumn get translation => text()();
  TextColumn get audioUrl => text().nullable()();
  TextColumn get imageUrl => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class BookmarksTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surahNumber => integer()();
  IntColumn get ayahNumber => integer()();
  TextColumn get surahName => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

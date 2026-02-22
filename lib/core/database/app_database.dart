import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import '../../features/quran/data/datasources/quran_tables.dart';
import '../../features/sholat/data/datasources/sholat_tables.dart';
import 'location_tables.dart';
import 'api_cache_table.dart';
import 'user_profile_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    SurahsTable,
    AyahsTable,
    BookmarksTable,
    PrayerSchedulesTable,
    NotificationSettingsTable,
    LocationCacheTable,
    ApiCacheTable,
    UserProfileTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase._() : super(_openConnection());

  static final AppDatabase instance = AppDatabase._();

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await m.createTable(surahsTable);
        await m.createTable(ayahsTable);
      }
      if (from < 3) {
        await m.createTable(bookmarksTable);
      }
      if (from < 4) {
        await m.createTable(prayerSchedulesTable);
        await m.createTable(notificationSettingsTable);
      }
      if (from < 5) {
        await m.createTable(locationCacheTable);
      }
      if (from < 6) {
        await m.createTable(apiCacheTable);
      }
      if (from < 7) {
        await m.createTable(userProfileTable);
      }
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'app_database');
  }
}

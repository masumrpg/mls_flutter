import 'package:drift/drift.dart';

class PrayerSchedulesTable extends Table {
  TextColumn get id => text()(); // e.g., cityId_date
  TextColumn get cityId => text()();
  TextColumn get cityName => text()();
  TextColumn get province => text()();
  TextColumn get date => text()(); // YYYY-MM-DD format
  TextColumn get imsak => text()();
  TextColumn get subuh => text()();
  TextColumn get terbit => text()();
  TextColumn get dhuha => text()();
  TextColumn get dzuhur => text()();
  TextColumn get ashar => text()();
  TextColumn get maghrib => text()();
  TextColumn get isya => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class NotificationSettingsTable extends Table {
  TextColumn get prayerName => text()(); // e.g., "Imsak", "Subuh", "Dzuhur"
  IntColumn get alertType => integer().withDefault(
    const Constant(1),
  )(); // 0: Mute, 1: Notification Only, 2: Adhan Sound
  IntColumn get preReminderMinutes =>
      integer().withDefault(const Constant(0))(); // 0, 5, 10, 15, 20

  @override
  Set<Column> get primaryKey => {prayerName};
}

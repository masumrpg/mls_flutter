import 'package:drift/drift.dart';

@DataClassName('UserProfile')
class UserProfileTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withDefault(const Constant('Ma\'sum'))();
  TextColumn get email =>
      text().withDefault(const Constant('masum@example.com'))();
  TextColumn get avatarUrl => text().nullable()();

  // Reading Progress
  RealColumn get completedPercentage => real().withDefault(const Constant(0.45))();
  IntColumn get currentJuz => integer().withDefault(const Constant(14))();
  IntColumn get totalJuz => integer().withDefault(const Constant(30))();

  // Activity
  RealColumn get weeklyHours => real().withDefault(const Constant(4.5))();
  RealColumn get weeklyTrend => real().withDefault(const Constant(0.12))(); // e.g. 0.12 = +12%

  // Statistics
  IntColumn get totalVerses => integer().withDefault(const Constant(135))();
  IntColumn get dailyAvgVerses => integer().withDefault(const Constant(19))();
}

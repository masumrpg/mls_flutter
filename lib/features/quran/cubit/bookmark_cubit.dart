import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/database/app_database.dart';

// State
class BookmarkState extends Equatable {
  final int? surahNumber;
  final int? ayahNumber;
  final String? surahName;
  final DateTime? createdAt;

  const BookmarkState({
    this.surahNumber,
    this.ayahNumber,
    this.surahName,
    this.createdAt,
  });

  bool get hasBookmark => surahNumber != null;

  @override
  List<Object?> get props => [surahNumber, ayahNumber, surahName, createdAt];
}

class BookmarkCubit extends Cubit<BookmarkState> {
  final AppDatabase db;

  BookmarkCubit({required this.db}) : super(const BookmarkState());

  /// Load the latest bookmark
  Future<void> loadLastRead() async {
    final rows = await (db.select(db.bookmarksTable)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(1))
        .get();

    if (rows.isNotEmpty) {
      final row = rows.first;
      emit(BookmarkState(
        surahNumber: row.surahNumber,
        ayahNumber: row.ayahNumber,
        surahName: row.surahName,
        createdAt: row.createdAt,
      ));
    }
  }

  /// Save a bookmark (last read position)
  Future<void> saveBookmark({
    required int surahNumber,
    required int ayahNumber,
    required String surahName,
  }) async {
    // Delete old bookmarks, keep only the latest
    await db.delete(db.bookmarksTable).go();

    await db.into(db.bookmarksTable).insert(
          BookmarksTableCompanion.insert(
            surahNumber: surahNumber,
            ayahNumber: ayahNumber,
            surahName: surahName,
          ),
        );

    emit(BookmarkState(
      surahNumber: surahNumber,
      ayahNumber: ayahNumber,
      surahName: surahName,
      createdAt: DateTime.now(),
    ));
  }
}

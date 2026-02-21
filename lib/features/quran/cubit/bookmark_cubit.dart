import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/database/app_database.dart';

class BookmarkState extends Equatable {
  // Last read properties (the singular latest bookmark for the banner)
  final int? surahNumber;
  final int? ayahNumber;
  final String? surahName;
  final DateTime? createdAt;

  // List of all bookmarks for the tab
  final List<dynamic> bookmarks;

  const BookmarkState({
    this.surahNumber,
    this.ayahNumber,
    this.surahName,
    this.createdAt,
    this.bookmarks = const [],
  });

  bool get hasBookmark => surahNumber != null;

  BookmarkState copyWith({
    int? surahNumber,
    int? ayahNumber,
    String? surahName,
    DateTime? createdAt,
    List<dynamic>? bookmarks,
  }) {
    return BookmarkState(
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      surahName: surahName ?? this.surahName,
      createdAt: createdAt ?? this.createdAt,
      bookmarks: bookmarks ?? this.bookmarks,
    );
  }

  @override
  List<Object?> get props => [
    surahNumber,
    ayahNumber,
    surahName,
    createdAt,
    bookmarks,
  ];
}

class BookmarkCubit extends Cubit<BookmarkState> {
  final AppDatabase db;

  BookmarkCubit({required this.db}) : super(const BookmarkState());

  /// Load both the latest read and all historical bookmarks
  Future<void> loadBookmarks() async {
    final rows = await (db.select(db.bookmarksTable)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();

    if (rows.isNotEmpty) {
      final latest = rows.first;
      emit(
        state.copyWith(
          surahNumber: latest.surahNumber,
          ayahNumber: latest.ayahNumber,
          surahName: latest.surahName,
          createdAt: latest.createdAt,
          bookmarks: rows,
      ));
    } else {
      emit(state.copyWith(bookmarks: []));
    }
  }


  /// Save a bookmark (last read position)
  Future<void> saveBookmark({
    required int surahNumber,
    required int ayahNumber,
    required String surahName,
  }) async {
    // Insert the new bookmark context.
    // If we want to prevent duplicate bookmarks for the exact same ayah, we can query first, but for now we append.

    await db.into(db.bookmarksTable).insert(
          BookmarksTableCompanion.insert(
            surahNumber: surahNumber,
            ayahNumber: ayahNumber,
            surahName: surahName,
          ),
        );

    // Reload all bookmarks so the tab list is updated
    await loadBookmarks();
  }
}

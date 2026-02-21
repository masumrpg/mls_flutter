import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../models/quran_model.dart';
import '../models/surah_detail_model.dart';

class QuranLocalDataSource {
  final AppDatabase db;

  QuranLocalDataSource(this.db);

  // ─── Surahs ──────────────────────────────────────────────────────

  Future<List<SurahModel>> getSurahs() async {
    final rows = await db.select(db.surahsTable).get();
    return rows
        .map((row) => SurahModel(
              number: row.number,
              name: row.name,
              nameLatin: row.nameLatin,
              numberOfAyahs: row.numberOfAyahs,
              translation: row.translation,
              revelation: row.revelation,
              description: row.description,
              audioUrl: row.audioUrl,
            ))
        .toList();
  }

  Future<bool> hasSurahs() async {
    final count = await db.select(db.surahsTable).get();
    return count.isNotEmpty;
  }

  Future<void> saveSurahs(List<SurahModel> surahs) async {
    await db.batch((batch) {
      batch.insertAllOnConflictUpdate(
        db.surahsTable,
        surahs
            .map((s) => SurahsTableCompanion.insert(
                  number: Value(s.number),
                  name: s.name,
                  nameLatin: s.nameLatin,
                  numberOfAyahs: s.numberOfAyahs,
                  translation: s.translation,
                  revelation: s.revelation,
                  description: s.description,
                  audioUrl: Value(s.audioUrl),
                ))
            .toList(),
      );
    });
  }

  // ─── Surah Detail (Ayahs) ────────────────────────────────────────

  Future<SurahDetailModel?> getSurahDetail(int surahNumber) async {
    // Get surah info
    final surahRows = await (db.select(db.surahsTable)
          ..where((t) => t.number.equals(surahNumber)))
        .get();

    if (surahRows.isEmpty) return null;

    final surah = surahRows.first;

    // Get ayahs
    final ayahRows = await (db.select(db.ayahsTable)
          ..where((t) => t.surahNumber.equals(surahNumber))
          ..orderBy([(t) => OrderingTerm.asc(t.ayahNumber)]))
        .get();

    if (ayahRows.isEmpty) return null;

    final ayahs = ayahRows
        .map((row) => AyahModel(
              id: row.id,
              surahNumber: row.surahNumber,
              ayahNumber: row.ayahNumber,
              arab: row.arab,
              translation: row.translation,
              audioUrl: row.audioUrl,
              imageUrl: row.imageUrl,
            ))
        .toList();

    return SurahDetailModel(
      number: surah.number,
      name: surah.name,
      nameLatin: surah.nameLatin,
      numberOfAyahs: surah.numberOfAyahs,
      translation: surah.translation,
      revelation: surah.revelation,
      description: surah.description,
      audioUrl: surah.audioUrl,
      ayahs: ayahs,
    );
  }

  Future<void> saveSurahDetail(SurahDetailModel detail) async {
    await db.batch((batch) {
      // Upsert surah
      batch.insertAllOnConflictUpdate(
        db.surahsTable,
        [
          SurahsTableCompanion.insert(
            number: Value(detail.number),
            name: detail.name,
            nameLatin: detail.nameLatin,
            numberOfAyahs: detail.numberOfAyahs,
            translation: detail.translation,
            revelation: detail.revelation,
            description: detail.description,
            audioUrl: Value(detail.audioUrl),
          ),
        ],
      );

      // Upsert ayahs
      batch.insertAllOnConflictUpdate(
        db.ayahsTable,
        detail.ayahs
            .map((a) => AyahsTableCompanion.insert(
                  id: Value((a as AyahModel).id),
                  surahNumber: a.surahNumber,
                  ayahNumber: a.ayahNumber,
                  arab: a.arab,
                  translation: a.translation,
                  audioUrl: Value(a.audioUrl),
                  imageUrl: Value(a.imageUrl),
                ))
            .toList(),
      );
    });
  }
}

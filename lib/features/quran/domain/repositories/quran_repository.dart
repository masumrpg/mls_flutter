import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/quran_entity.dart';

import '../entities/surah_detail_entity.dart';

abstract class QuranRepository {
  Future<Either<Failure, List<SurahEntity>>> getSurahs();
  Future<Either<Failure, SurahDetailEntity>> getSurahDetail(int surahNumber);
}

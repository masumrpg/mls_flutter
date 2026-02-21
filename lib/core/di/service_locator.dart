import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/storage_service.dart';
import '../network/api_client.dart';
import '../database/app_database.dart';

import '../../features/sholat/data/datasources/sholat_remote_datasource.dart';
import '../../features/sholat/data/datasources/sholat_local_datasource.dart';
import '../../features/sholat/data/repositories/sholat_repository_impl.dart';
import '../../features/sholat/domain/repositories/sholat_repository.dart';
import '../../features/sholat/bloc/sholat_schedule_bloc.dart';
import '../services/location_service.dart';

import '../../features/quran/data/datasources/quran_remote_datasource.dart';
import '../../features/quran/data/datasources/quran_local_datasource.dart';
import '../../features/quran/data/repositories/quran_repository_impl.dart';
import '../../features/quran/domain/repositories/quran_repository.dart';
import '../../features/quran/bloc/quran_bloc.dart';
import '../../features/quran/bloc/surah_detail_bloc.dart';

import '../../features/hadis/data/datasources/hadis_remote_datasource.dart';
import '../../features/hadis/data/repositories/hadis_repository_impl.dart';
import '../../features/hadis/domain/repositories/hadis_repository.dart';
import '../../features/hadis/bloc/hadis_bloc.dart';

import '../../features/kalender/data/datasources/kalender_remote_datasource.dart';
import '../../features/kalender/data/repositories/kalender_repository_impl.dart';
import '../../features/kalender/domain/repositories/kalender_repository.dart';
import '../../features/kalender/bloc/kalender_bloc.dart';

import '../../features/profil/data/datasources/profil_remote_datasource.dart';
import '../../features/profil/data/repositories/profil_repository_impl.dart';
import '../../features/profil/domain/repositories/profil_repository.dart';
import '../../features/profil/bloc/profil_bloc.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Storage
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => StorageService(prefs));

  // Network
  sl.registerLazySingleton(() => ApiClient());

  // Database
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase.instance);

  // ─── Core Services ───────────────────────────────────────────────
  sl.registerLazySingleton<LocationService>(() => LocationService());

  // ─── Sholat Feature ──────────────────────────────────────────────
  sl.registerLazySingleton<SholatRemoteDataSource>(
    () => SholatRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<SholatLocalDataSource>(
    () => SholatLocalDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<SholatRepository>(
    () => SholatRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      locationService: sl(),
    ),
  );

  sl.registerFactory<SholatScheduleBloc>(
    () => SholatScheduleBloc(repository: sl()),
  );

  // ─── Quran Feature ──────────────────────────────────────────────
  sl.registerLazySingleton<QuranRemoteDataSource>(
    () => QuranRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<QuranLocalDataSource>(
    () => QuranLocalDataSource(sl()),
  );

  sl.registerLazySingleton<QuranRepository>(
    () => QuranRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  sl.registerFactory<QuranBloc>(
    () => QuranBloc(repository: sl()),
  );

  sl.registerFactory<SurahDetailBloc>(
    () => SurahDetailBloc(repository: sl()),
  );

  // ─── Hadis Feature ──────────────────────────────────────────────
  sl.registerLazySingleton<HadisRemoteDataSource>(
    () => HadisRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<HadisRepository>(
    () => HadisRepositoryImpl(sl()),
  );

  sl.registerFactory<HadisBloc>(
    () => HadisBloc(repository: sl()),
  );

  // ─── Kalender Feature ───────────────────────────────────────────
  sl.registerLazySingleton<KalenderRemoteDataSource>(
    () => KalenderRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<KalenderRepository>(
    () => KalenderRepositoryImpl(sl()),
  );

  sl.registerFactory<KalenderBloc>(
    () => KalenderBloc(repository: sl()),
  );

  // ─── Profil Feature ───────────────────────────────────────────
  sl.registerLazySingleton<ProfilRemoteDataSource>(
    () => ProfilRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<ProfilRepository>(
    () => ProfilRepositoryImpl(sl()),
  );

  sl.registerFactory<ProfilBloc>(
    () => ProfilBloc(repository: sl()),
  );
}

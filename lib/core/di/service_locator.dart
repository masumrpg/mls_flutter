import 'package:get_it/get_it.dart';
import '../../features/notes/data/datasources/notes_local_datasource.dart';
import '../../features/notes/data/datasources/notes_remote_datasource.dart';
import '../../features/notes/data/repositories/notes_repository_impl.dart';
import '../../features/notes/domain/repositories/notes_repository.dart';
import '../../features/notes/bloc/notes_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../database/app_database.dart';

import '../../features/sholat/data/datasources/sholat_remote_datasource.dart';
import '../../features/sholat/data/repositories/sholat_repository_impl.dart';
import '../../features/sholat/domain/repositories/sholat_repository.dart';
import '../../features/sholat/bloc/sholat_schedule_bloc.dart';

import '../../features/qibla/data/datasources/qibla_remote_datasource.dart';
import '../../features/qibla/data/repositories/qibla_repository_impl.dart';
import '../../features/qibla/domain/repositories/qibla_repository.dart';
import '../../features/qibla/bloc/qibla_bloc.dart';

import '../../features/quran/data/datasources/quran_remote_datasource.dart';
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

import 'package:shared_preferences/shared_preferences.dart';
import '../services/storage_service.dart';
import '../network/api_client.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Storage
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => StorageService(prefs));

  // Network
  sl.registerLazySingleton(() => ApiClient());

  // Repositories
  // Example: sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // Data sources
  // Example: sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl()));

  // BLoCs (if needed globally)
  // Example: sl.registerFactory(() => AuthBloc(sl()));
  // ─── Offline-First: Notes ────────────────────────────────────────
  // Database
  if (!sl.isRegistered<AppDatabase>()) {
    sl.registerLazySingleton<AppDatabase>(() => AppDatabase.instance);
  }

  // Connectivity
  if (!sl.isRegistered<Connectivity>()) {
    sl.registerLazySingleton<Connectivity>(() => Connectivity());
  }

  // Local Datasource
  sl.registerLazySingleton<NotesLocalDatasource>(
    () => NotesLocalDatasource(sl()),
  );

  // Remote Datasource
  sl.registerLazySingleton<NotesRemoteDataSource>(
    () => NotesRemoteDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<NotesRepository>(
    () => NotesRepositoryImpl(
      localDatasource: sl(),
      remoteDatasource: sl(),
      connectivity: sl(),
    ),
  );

  // BLoC
  sl.registerFactory<NotesBloc>(
    () => NotesBloc(
      repository: sl(),
      connectivity: sl(),
    ),
  );

  // ─── Sholat Feature ──────────────────────────────────────────────
  sl.registerLazySingleton<SholatRemoteDataSource>(
    () => SholatRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<SholatRepository>(
    () => SholatRepositoryImpl(sl()),
  );

  sl.registerFactory<SholatScheduleBloc>(
    () => SholatScheduleBloc(repository: sl()),
  );

  // ─── Qibla Feature ──────────────────────────────────────────────
  sl.registerLazySingleton<QiblaRemoteDataSource>(
    () => QiblaRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<QiblaRepository>(
    () => QiblaRepositoryImpl(sl()),
  );

  sl.registerFactory<QiblaBloc>(
    () => QiblaBloc(repository: sl()),
  );

  // ─── Quran Feature ──────────────────────────────────────────────
  sl.registerLazySingleton<QuranRemoteDataSource>(
    () => QuranRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<QuranRepository>(
    () => QuranRepositoryImpl(sl()),
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

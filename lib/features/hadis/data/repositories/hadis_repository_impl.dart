import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart' as drift;
import '../../../../core/error/failure.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/repositories/hadis_repository.dart';
import '../models/hadis_model.dart';

class HadisRepositoryImpl implements HadisRepository {
  final Dio _dio;
  final AppDatabase _db;

  HadisRepositoryImpl(this._dio, this._db);

  @override
  Future<Either<Failure, HadisResponseModel>> getExplore(
    int page,
    int limit,
  ) async {
    final endpoint = '/hadis/enc/explore?page=$page&limit=$limit';
    return _fetchAndCache<HadisResponseModel>(
      endpoint: endpoint,
      parser: (json) => HadisResponseModel.fromJson(json),
    );
  }

  @override
  Future<Either<Failure, HadisResponseModel>> searchHadis(
    String query,
    int page,
    int limit,
  ) async {
    final endpoint = '/hadis/enc/cari/$query?page=$page&limit=$limit';
    return _fetchAndCache<HadisResponseModel>(
      endpoint: endpoint,
      parser: (json) => HadisResponseModel.fromJson(json),
    );
  }

  @override
  Future<Either<Failure, HadisModel>> getHadisDetail(int id) async {
    final endpoint = '/hadis/enc/show/$id';
    return _fetchAndCache<HadisModel>(
      endpoint: endpoint,
      parser: (json) {
        final data = json['data'] as Map<String, dynamic>?;
        if (data != null) {
          return HadisModel.fromJson(data);
        }
        throw Exception('Invalid data format');
      },
    );
  }

  /// Generic method to fetch from Cache first, return immediately if exists,
  /// then silently background re-fetch to update DB if successful, or fallback to API directly if no cache exists.
  Future<Either<Failure, T>> _fetchAndCache<T>({
    required String endpoint,
    required T Function(Map<String, dynamic> json) parser,
  }) async {
    try {
      // 1. Check local cache first
      final cachedString = await (_db.select(
        _db.apiCacheTable,
      )..where((t) => t.endpoint.equals(endpoint))).getSingleOrNull();

      if (cachedString != null) {
        try {
          final jsonMap = jsonDecode(cachedString.responseBody);
          // 2. Return cached instance immediately
          final parsedCache = parser(jsonMap);

          // 3. Trigger a background refresh (fire and forget)
          _dio
              .get(endpoint)
              .then((response) {
                if (response.statusCode == 200 && response.data != null) {
                  _db
                      .into(_db.apiCacheTable)
                      .insertOnConflictUpdate(
                        ApiCacheTableCompanion(
                          endpoint: drift.Value(endpoint),
                          responseBody: drift.Value(jsonEncode(response.data)),
                          updatedAt: drift.Value(DateTime.now()),
                        ),
                      );
                }
              })
              .catchError((_) {
                // Ignore background refresh errors
              });

          return Right(parsedCache);
        } catch (e) {
          // If parsing cached data fails, proceed to fetch from API
        }
      }

      // No cache or cache parsing failed, fetch directly from API
      final response = await _dio.get(endpoint);
      if (response.statusCode == 200 && response.data != null) {
        // Cache the result
        await _db
            .into(_db.apiCacheTable)
            .insertOnConflictUpdate(
              ApiCacheTableCompanion(
                endpoint: drift.Value(endpoint),
                responseBody: drift.Value(jsonEncode(response.data)),
                updatedAt: drift.Value(DateTime.now()),
              ),
            );

        return Right(parser(response.data));
      } else {
        return Left(
          ServerFailure(
            'Server Error [${response.statusCode}]: ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Unknown error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

import 'dart:io';
import 'package:drift/drift.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../database/app_database.dart';

class LocationService {
  Future<Position?> getCurrentPosition() async {
    // 1. Desktop Fallback (Jakarta)
    if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      return _getFallbackPosition();
    }

    // 2. Check Database Cache
    try {
      final db = AppDatabase.instance;
      final cached = await (db.select(
        db.locationCacheTable,
      )..limit(1)).getSingleOrNull();

      if (cached != null) {
        return Position(
          longitude: cached.longitude,
          latitude: cached.latitude,
          timestamp: cached.updatedAt,
          accuracy: 0.0,
          altitude: 0.0,
          altitudeAccuracy: 0.0,
          heading: 0.0,
          headingAccuracy: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
        );
      }
    } catch (_) {}

    // 3. Request Current Position (Mobile/Fallback)
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return await _getFallbackPosition();
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return await _getFallbackPosition();
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return await _getFallbackPosition();
      }

      final pos =
          await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
        ),
      ).timeout(
        const Duration(seconds: 5),
            onTimeout: () async {
              final fallback = await _getFallbackPosition();
              if (fallback != null) return fallback;
              throw Exception('Timeout and no fallback');
        },
      );

      // Save to cache memory if successfully retrieved real coordinate
      try {
        final db = AppDatabase.instance;
        await db
            .into(db.locationCacheTable)
            .insertOnConflictUpdate(
              LocationCacheTableCompanion.insert(
                id: const Value(1),
                latitude: pos.latitude,
                longitude: pos.longitude,
                cityName: '',
                updatedAt: DateTime.now(),
              ),
            );
      } catch (_) {}

      return pos;
    } catch (e) {
      return await _getFallbackPosition();
    }
  }

  Future<Position?> _getFallbackPosition() async {
    try {
      final db = AppDatabase.instance;
      final cached = await (db.select(
        db.locationCacheTable,
      )..limit(1)).getSingleOrNull();

      if (cached != null) {
        return Position(
          longitude: cached.longitude,
          latitude: cached.latitude,
          timestamp: cached.updatedAt,
          accuracy: 0.0,
          altitude: 0.0,
          altitudeAccuracy: 0.0,
          heading: 0.0,
          headingAccuracy: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
        );
      }

      if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
        return Position(
          longitude: 106.816666,
          latitude: -6.200000,
          timestamp: DateTime.now(),
          accuracy: 0.0,
          altitude: 0.0,
          altitudeAccuracy: 0.0,
          heading: 0.0,
          headingAccuracy: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
        );
      }
    } catch (_) {
      // Ignore if Platform checking fails (e.g. on web)
    }
    return null;
  }

  Future<String?> getCityName() async {
    final position = await getCurrentPosition();
    if (position == null) return null;

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        // Placemark usually has subAdministrativeArea for Kab/Kota, or locality
        String cityName = place.subAdministrativeArea ?? place.locality ?? '';

        // Sometimes Geocoding API fails to return proper city for Jakarta coordinates
        if (cityName.isEmpty && position.latitude == -6.200000) {
          return 'Jakarta';
        }
        return cityName;
      }
    } catch (e) {
      if (position.latitude == -6.200000) return 'Jakarta';
      return null;
    }
    return null;
  }
}

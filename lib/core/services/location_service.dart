import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  Future<Position?> getCurrentPosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return _getFallbackPosition();
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return _getFallbackPosition();
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return _getFallbackPosition();
      }

      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
        ),
      ).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return _getFallbackPosition()!;
        },
      );
    } catch (e) {
      return _getFallbackPosition();
    }
  }

  Position? _getFallbackPosition() {
    try {
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

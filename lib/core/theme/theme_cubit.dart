import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/storage_service.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final StorageService _storageService;
  static const String _themeKey = 'theme_mode';

  ThemeCubit(this._storageService) : super(ThemeMode.system) {
    _loadTheme();
  }

  void _loadTheme() {
    final savedTheme = _storageService.getString(_themeKey);
    if (savedTheme != null) {
      final mode = ThemeMode.values.firstWhere(
        (e) => e.toString() == savedTheme,
        orElse: () => ThemeMode.system,
      );
      emit(mode);
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    emit(mode);
    await _storageService.setString(_themeKey, mode.toString());
  }

  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(newMode);
  }

  bool get isDark => state == ThemeMode.dark;
  bool get isLight => state == ThemeMode.light;
  bool get isSystem => state == ThemeMode.system;
}

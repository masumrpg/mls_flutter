import 'package:flutter/material.dart';

class AppColors {
  // Primary & Secondary
  static const primary = Color(0xFF1E3A8A); // Biru Dongker / Dark Blue
  static const secondary = Color(0xFFF59E0B); // Amber / Gold untuk aksen

  // Accent
  static const onPrimary = Color.fromARGB(255, 23, 48, 117);

  // Semantic
  static const error = Color(0xFFDC2626);
  static const success = Color(0xFF16A34A);
  static const warning = Color(0xFFD97706);

  // Neutral (Light mode)
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF0F172A); // Slate 900
  static const grey = Color(0xFF64748B); // Slate 500
  static const lightGrey = Color(0xFFE2E8F0); // Slate 200
  static const background = Color(0xFFF8FAFC); // Slate 50

  // Dark mode specific
  static const darkBackground = Color(0xFF0F172A); // Slate 900
  static const darkSurface = Color(0xFF1E293B); // Slate 800
  static const darkCard = Color(0xFF334155); // Slate 700
  static const darkText = Color(0xFFF1F5F9); // Slate 100
  static const darkTextSecondary = Color(0xFF94A3B8);
}

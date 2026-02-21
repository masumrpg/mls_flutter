import 'package:logger/logger.dart';

class Log {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
  );

  /// Verbose log
  static void t(String message) => _logger.t(message);

  /// Debug log
  static void d(String message) => _logger.d(message);

  /// Info log
  static void i(String message) => _logger.i(message);

  /// Warning log
  static void w(String message) => _logger.w(message);

  /// Error log
  static void e(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);

  /// What a terrible failure log
  static void f(String message) => _logger.f(message);
}

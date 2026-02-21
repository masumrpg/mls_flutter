import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';
import 'app.dart';
import 'core/di/service_locator.dart';
import 'core/services/notification_service.dart';
import 'core/services/background_fetch_task.dart';
import 'shared/blocs/app_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize mobile-only services
  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
    // Initialize notifications
    await NotificationService.instance.initialize();

    // Initialize background fetch job
    Workmanager().initialize(callbackDispatcher);
  }

  // Setup dependency injection
  await setupServiceLocator();

  // Setup BLoC observer
  Bloc.observer = AppBlocObserver();

  runApp(const App());
}

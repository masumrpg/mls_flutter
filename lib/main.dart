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

  // Initialize services for native platforms
  if (!kIsWeb) {
    // Initialize notifications and request permissions
    await NotificationService.instance.initialize();
    await NotificationService.instance.requestPermission();

    // Workmanager is typically for mobile only
    if (Platform.isAndroid || Platform.isIOS) {
      Workmanager().initialize(callbackDispatcher);
    }
  }

  // Setup dependency injection
  await setupServiceLocator();

  // Setup BLoC observer
  Bloc.observer = AppBlocObserver();

  runApp(const App());
}

import 'package:workmanager/workmanager.dart';
import '../di/service_locator.dart';
import '../../features/sholat/domain/repositories/sholat_repository.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      // Re-initialize dependencies since this runs in a separate isolate
      await setupServiceLocator();

      final repository = sl<SholatRepository>();
      // Execute fetch for current location (which will cache the result if successful)
      final result = await repository.getScheduleForCurrentLocation();

      return result.fold(
        (failure) => false,
        (schedule) => true,
      );
    } catch (e) {
      return false;
    }
  });
}

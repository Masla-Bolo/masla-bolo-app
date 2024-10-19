import 'package:masla_bolo_app/service/permission_service.dart';

import '../image_service.dart';
import '../location_service.dart';
import '../music_service.dart';
import '../notification_service.dart';
import '../utility_service.dart';

import '../../di/service_locator.dart';

class ServiceInjection {
  static Future<void> configureServiceLayerInjction() async {
    getIt.registerSingleton<PermissionService>(PermissionService());
    getIt.registerSingleton<NotificationService>(
      NotificationService(
        getIt(),
        getIt(),
      ),
    );
    getIt.registerSingleton<LocationService>(LocationService());
    getIt.registerSingleton<MusicService>(MusicService());
    getIt.registerSingleton<UtilityService>(UtilityService());
    getIt.registerSingleton<ImageService>(ImageService());
  }
}

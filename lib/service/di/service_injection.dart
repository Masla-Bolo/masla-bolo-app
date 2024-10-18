import 'package:masla_bolo_app/service/notification_service.dart';

import '../image_service.dart';
import '../music_service.dart';
import '../utility_service.dart';

import '../../di/service_locator.dart';

class ServiceInjection {
  static Future<void> configureServiceLayerInjction() async {
    getIt
        .registerSingleton<NotificationService>(
          NotificationService(
            getIt(),
            getIt(),
          ),
        )
        .initNotifications();
    getIt.registerSingleton<MusicService>(MusicService());
    getIt.registerSingleton<UtilityService>(UtilityService());
    getIt.registerSingleton<ImageService>(ImageService());
  }
}

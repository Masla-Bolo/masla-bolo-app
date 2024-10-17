import '../image_service.dart';
import '../music_service.dart';
import '../utility_service.dart';

import '../../di/service_locator.dart';

class ServiceInjection {
  static Future<void> configureServiceLayerInjction() async {
    getIt.registerSingleton<MusicService>(MusicService());
    getIt.registerSingleton<UtilityService>(UtilityService());
    getIt.registerSingleton<ImageService>(ImageService());
  }
}

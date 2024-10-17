import 'package:masla_bolo_app/service/image_service.dart';
import 'package:masla_bolo_app/service/music_service.dart';
import 'package:masla_bolo_app/service/utility_service.dart';

import '../../di/service_locator.dart';

class ServiceInjection {
  static Future<void> configureServiceLayerInjction() async {
    getIt.registerSingleton<MusicService>(MusicService());
    getIt.registerSingleton<UtilityService>(UtilityService());
    getIt.registerSingleton<ImageService>(ImageService());
  }
}

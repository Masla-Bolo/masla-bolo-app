import 'package:masla_bolo_app/network/dio/dio_client.dart';
import 'package:masla_bolo_app/network/dio/interceptors/network_interceptor.dart';

import '../../../di/service_locator.dart';

class DioModule {
  static Future<void> configureDioModuleInjection() async {
    getIt.registerSingleton<NetworkInterceptor>(
      NetworkInterceptor(getIt()),
    );
    getIt.registerSingleton<DioClient>(
      DioClient(
        interceptors: [
          getIt<NetworkInterceptor>(),
        ],
      ),
    );
  }
}

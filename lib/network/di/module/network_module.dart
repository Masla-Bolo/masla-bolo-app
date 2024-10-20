import 'package:masla_bolo_app/service/network_monitor.dart';

import '../../network_repository.dart';

import '../../../di/service_locator.dart';

class NetworkModule {
  static Future<void> configureNetwokModuleInjection() async {
    getIt.registerSingleton<NetworkMonitor>(NetworkMonitor());
    getIt.registerSingleton<NetworkRepository>(NetworkRepository(
      getIt(),
      getIt(),
    ));
  }
}

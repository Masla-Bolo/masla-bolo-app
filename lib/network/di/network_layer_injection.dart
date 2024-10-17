import 'package:masla_bolo_app/network/di/module/dio_module.dart';
import 'package:masla_bolo_app/network/di/module/network_module.dart';

class NetworkLayerInjection {
  static Future<void> configureNetworkLayerInjection() async {
    await DioModule.configureDioModuleInjection();
    await NetworkModule.configureNetwokModuleInjection();
  }
}

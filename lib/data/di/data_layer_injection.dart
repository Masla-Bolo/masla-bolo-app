import 'package:masla_bolo_app/data/di/module/local_module.dart';

class DataLayerInjection {
  static Future<void> configureDataLayerInjction() async {
    await LocalModule.configureLocalModuleInjection();
  }
}

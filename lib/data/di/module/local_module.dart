import '../../local_storage/local_storage_repository.dart';

import '../../../di/service_locator.dart';

class LocalModule {
  static Future<void> configureLocalModuleInjection() async {
    getIt.registerSingleton<LocalStorageRepository>(LocalStorageRepository());
  }
}

import '../../stores/user_store.dart';

import '../../../di/service_locator.dart';

class StoreModule {
  static Future<void> configureStoreModuleInjection() async {
    getIt.registerSingleton<UserStore>(UserStore(getIt()));
  }
}

import '../../../data/user/api_user_repository.dart';

import '../../../di/service_locator.dart';
import '../../repositories/user_repository.dart';

class UserModule {
  static Future<void> configureUserModuleInjection() async {
    getIt.registerSingleton<UserRepository>(
      ApiUserRepository(
        getIt(),
        getIt(),
      ),
    );
  }
}
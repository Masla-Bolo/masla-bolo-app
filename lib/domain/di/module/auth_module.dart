import '../../../data/auth/api_auth_repository.dart';
import '../../repositories/auth_repository.dart';

import '../../../di/service_locator.dart';

class AuthModule {
  static Future<void> configureAuthModuleInjection() async {
    getIt.registerSingleton<AuthRepository>(
      ApiAuthRepository(
        getIt(),
        getIt(),
      ),
    );
  }
}

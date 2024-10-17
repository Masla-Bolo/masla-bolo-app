import 'package:masla_bolo_app/data/auth/api_auth_repository.dart';
import 'package:masla_bolo_app/domain/repositories/auth_repository.dart';

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

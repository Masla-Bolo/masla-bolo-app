import '../../../di/service_locator.dart';
import '../../auth/auth_cubit.dart';
import '../../auth/auth_navigator.dart';

class PresentationAuthModule {
  static Future<void> configurePresentaionAuthModuleInjection() async {
    getIt.registerSingleton<AuthNavigator>(AuthNavigator(getIt()));
    getIt.registerSingleton<AuthCubit>(AuthCubit(
      getIt(),
      getIt(),
      getIt(),
    ));
  }
}

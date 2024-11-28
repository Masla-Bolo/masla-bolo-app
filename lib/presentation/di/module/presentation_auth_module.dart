import '../../../di/service_locator.dart';
import '../../auth/auth_cubit.dart';
import '../../auth/auth_navigator.dart';

class PresentationAuthModule {
  static Future<void> configurePresentaionAuthModuleInjection() async {
    getIt.registerLazySingleton<AuthNavigator>(() => AuthNavigator(getIt()));
    getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(
          getIt(),
          getIt(),
          getIt(),
          getIt(),
          getIt(),
        ));
  }
}

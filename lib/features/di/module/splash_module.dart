import '../../../di/service_locator.dart';
import '../../splash/splash_cubit.dart';
import '../../splash/splash_navigator.dart';

class SplashModule {
  static Future<void> configureSplashModuleInjection() async {
    getIt.registerSingleton<SplashNavigator>(SplashNavigator(getIt()));
    getIt.registerSingleton<SplashCubit>(SplashCubit(getIt(), getIt()));
  }
}

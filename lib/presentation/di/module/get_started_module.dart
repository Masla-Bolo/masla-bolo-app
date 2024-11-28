import '../../../di/service_locator.dart';
import '../../get_started/get_started_cubit.dart';
import '../../get_started/get_started_navigator.dart';

class GetStartedModule {
  static Future<void> configureGetStartedModuleInjection() async {
    getIt.registerLazySingleton<GetStartedNavigator>(
        () => GetStartedNavigator(getIt()));
    getIt.registerLazySingleton<GetStartedCubit>(() => GetStartedCubit(
          getIt(),
          getIt(),
        ));
  }
}

import '../../bottom_bar/bottom_bar_navigator.dart';

import '../../../di/service_locator.dart';
import '../../bottom_bar/bottom_bar_cubit.dart';

class BottomBarModule {
  static Future<void> configureBottomBarModuleInjection() async {
    getIt.registerLazySingleton<BottomBarNavigator>(
        () => BottomBarNavigator(getIt()));
    getIt.registerLazySingleton<BottomBarCubit>(() => BottomBarCubit(getIt()));
  }
}

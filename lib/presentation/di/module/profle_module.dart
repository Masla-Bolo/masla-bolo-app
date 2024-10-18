import '../../../di/service_locator.dart';
import '../../profile/components/settings/settings_cubit.dart';
import '../../profile/components/settings/settings_navigator.dart';
import '../../profile/profile_cubit.dart';
import '../../profile/profile_navigator.dart';

class ProfileModule {
  static Future<void> configureProfileModuleInjection() async {
    getIt.registerSingleton<ProfileNavigator>(ProfileNavigator(getIt()));
    getIt.registerSingleton<ProfileCubit>(ProfileCubit(
      getIt(),
      getIt(),
      getIt(),
      getIt(),
    ));
    getIt.registerLazySingleton<SettingsNavigator>(
      () => SettingsNavigator(getIt()),
    );
    getIt.registerLazySingleton<SettingsCubit>(
      () => SettingsCubit(
        getIt(),
        getIt(),
      ),
    );
  }
}

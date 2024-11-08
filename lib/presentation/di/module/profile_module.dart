import 'package:masla_bolo_app/presentation/profile/components/official_profile/official_profile_cubit.dart';

import '../../../di/service_locator.dart';
import '../../profile/components/base_profile/base_profile_issues_service.dart';
import '../../profile/components/settings/settings_cubit.dart';
import '../../profile/components/settings/settings_navigator.dart';
import '../../profile/components/user_profile/user_profile_cubit.dart';
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
    getIt.registerLazySingleton<OfficialProfileCubit>(
      () => OfficialProfileCubit(
          getIt(),
          BaseProfileIssuesService(
            issueRepository: getIt(),
            role: "official",
          )),
    );
    getIt.registerLazySingleton<UserProfileCubit>(
      () => UserProfileCubit(
          getIt(),
          BaseProfileIssuesService(
            issueRepository: getIt(),
            role: "user",
          )),
    );
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

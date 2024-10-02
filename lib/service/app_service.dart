import 'package:masla_bolo_app/data/auth/api_auth_repository.dart';
import 'package:masla_bolo_app/data/comment/api_comment_repository.dart';
import 'package:masla_bolo_app/data/issue/api_issue_repository.dart';
import 'package:masla_bolo_app/data/local_storage/primary_local_storage_repository.dart';
import 'package:masla_bolo_app/domain/repositories/auth_repository.dart';
import 'package:masla_bolo_app/domain/repositories/comment_repository.dart';
import 'package:masla_bolo_app/domain/repositories/issue_repository.dart';
import 'package:masla_bolo_app/domain/repositories/local_storage_repository.dart';
import 'package:masla_bolo_app/domain/stores/user_store.dart';
import 'package:masla_bolo_app/features/auth/auth_cubit.dart';
import 'package:masla_bolo_app/features/auth/auth_navigator.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_cubit.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_navigator.dart';
import 'package:masla_bolo_app/features/get_started/get_started_cubit.dart';
import 'package:masla_bolo_app/features/get_started/get_started_navigator.dart';
import 'package:masla_bolo_app/features/home/home_cubit.dart';
import 'package:masla_bolo_app/features/home/components/issue_detail/issue_detail_initial_params.dart';
import 'package:masla_bolo_app/features/issue/issue_cubit.dart';
import 'package:masla_bolo_app/features/notification/notification_cubit.dart';
import 'package:masla_bolo_app/features/profile/components/settings_cubit.dart';
import 'package:masla_bolo_app/features/profile/components/settings_navigator.dart';
import 'package:masla_bolo_app/features/profile/profile_navigator.dart';
import 'package:masla_bolo_app/features/splash/splash_cubit.dart';
import 'package:masla_bolo_app/helpers/image_helper.dart';
import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/features/splash/splash_navigator.dart';
import 'package:masla_bolo_app/network/network_repository.dart';
import 'package:masla_bolo_app/service/api_service.dart';
import 'package:get_it/get_it.dart';

import '../features/home/home_navigator.dart';
import '../features/home/components/issue_detail/issue_detail_cubit.dart';
import '../features/home/components/issue_detail/issue_detail_navigator.dart';
import '../features/issue/issue_navigator.dart';
import '../features/notification/notification_navigator.dart';
import '../features/profile/profile_cubit.dart';

final getIt = GetIt.instance;

class AppService {
  static Future<void> initialize() async {
    getIt.registerSingleton<LocalStorageRepository>(
        PrimaryLocalStorageRepository());
    getIt.registerSingleton<ApiService>(ApiService(getIt()));
    getIt.registerSingleton<NetworkRepository>(NetworkRepository(getIt()));
    getIt.registerSingleton<AppNavigation>(AppNavigation());
    getIt.registerSingleton<IssueRepository>(ApiIssueRepository(getIt()));
    getIt.registerSingleton<CommentRepository>(ApiCommentRepository(getIt()));
    getIt.registerSingleton<GetStartedNavigator>(GetStartedNavigator(getIt()));
    getIt.registerSingleton<GetStartedCubit>(GetStartedCubit(getIt(), getIt()));
    getIt.registerSingleton<SplashNavigator>(SplashNavigator(getIt()));
    getIt.registerSingleton<SplashCubit>(SplashCubit(getIt(), getIt()));
    getIt.registerSingleton<HomeNavigator>(HomeNavigator(getIt()));
    getIt
        .registerSingleton<HomeCubit>(HomeCubit(getIt(), getIt())..getIssues());
    getIt.registerSingleton<ImageHelper>(ImageHelper());
    getIt.registerFactoryParam<IssueDetailCubit, IssueDetailInitialParams,
        dynamic>(
      (params, _) => IssueDetailCubit(
        params,
        getIt(),
        getIt(),
        getIt(),
      ),
    );
    getIt
        .registerSingleton<IssueDetailNavigator>(IssueDetailNavigator(getIt()));
    getIt.registerSingleton<IssueNavigator>(IssueNavigator(getIt()));
    getIt.registerSingleton<IssueCubit>(IssueCubit(getIt(), getIt(), getIt()));
    getIt.registerSingleton<ProfileNavigator>(ProfileNavigator(getIt()));
    getIt.registerSingleton<ProfileCubit>(ProfileCubit(getIt()));
    getIt.registerSingleton<AuthNavigator>(AuthNavigator(getIt()));
    getIt.registerSingleton<UserStore>(UserStore());
    getIt.registerSingleton<AuthRepository>(ApiAuthRepository(
      getIt(),
      getIt(),
    ));
    getIt.registerSingleton<AuthCubit>(AuthCubit(getIt(), getIt(), getIt()));
    getIt.registerLazySingleton<NotificationNavigator>(
      () => NotificationNavigator(getIt()),
    );
    getIt.registerLazySingleton<NotificationCubit>(
      () => NotificationCubit(getIt()),
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
    getIt.registerSingleton<BottomBarNavigator>(BottomBarNavigator(getIt()));
    getIt.registerSingleton<BottomBarCubit>(BottomBarCubit(getIt()));
  }
}

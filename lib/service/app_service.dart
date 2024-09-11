import 'package:masla_bolo_app/data/auth/api_auth_repository.dart';
import 'package:masla_bolo_app/data/local_storage/primary_local_storage_repository.dart';
import 'package:masla_bolo_app/domain/repositories/auth_repository.dart';
import 'package:masla_bolo_app/domain/repositories/local_storage_repository.dart';
import 'package:masla_bolo_app/domain/stores/user_store.dart';
import 'package:masla_bolo_app/features/auth/auth_cubit.dart';
import 'package:masla_bolo_app/features/auth/auth_navigator.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_cubit.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_navigator.dart';
import 'package:masla_bolo_app/features/get_started/get_started_cubit.dart';
import 'package:masla_bolo_app/features/get_started/get_started_navigator.dart';
import 'package:masla_bolo_app/features/home/home_cubit.dart';
import 'package:masla_bolo_app/features/issue/issue_cubit.dart';
import 'package:masla_bolo_app/features/splash/splash_cubit.dart';
import 'package:masla_bolo_app/helpers/image_helper.dart';
import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/features/splash/splash_navigator.dart';
import 'package:masla_bolo_app/network/network_repository.dart';
import 'package:masla_bolo_app/service/api_service.dart';
import 'package:get_it/get_it.dart';

import '../features/home/home_navigator.dart';
import '../features/issue/components/issue_detail/issue_detail_cubit.dart';
import '../features/issue/components/issue_detail/issue_detail_navigator.dart';
import '../features/issue/issue_navigator.dart';

class AppService {
  static Future<void> initialize(GetIt getIt) async {
    getIt.registerSingleton<LocalStorageRepository>(
        PrimaryLocalStorageRepository());
    getIt.registerSingleton<AppNavigation>(AppNavigation());
    getIt.registerSingleton<GetStartedNavigator>(GetStartedNavigator(getIt()));
    getIt.registerSingleton<GetStartedCubit>(GetStartedCubit(getIt(), getIt()));
    getIt.registerSingleton<ApiService>(ApiService(getIt()));
    getIt.registerSingleton<SplashNavigator>(SplashNavigator(getIt()));
    getIt.registerSingleton<SplashCubit>(SplashCubit(getIt(), getIt()));
    getIt.registerSingleton<NetworkRepository>(NetworkRepository(getIt()));
    getIt.registerSingleton<HomeNavigator>(HomeNavigator(getIt()));
    getIt.registerSingleton<HomeCubit>(HomeCubit(getIt()));
    getIt.registerSingleton<ImageHelper>(ImageHelper());
    getIt
        .registerSingleton<IssueDetailNavigator>(IssueDetailNavigator(getIt()));
    getIt.registerSingleton<IssueDetailCubit>(
        IssueDetailCubit(getIt(), getIt()));
    getIt.registerSingleton<IssueNavigator>(IssueNavigator(getIt()));
    getIt.registerSingleton<IssueCubit>(IssueCubit(getIt(), getIt()));
    getIt.registerSingleton<AuthNavigator>(AuthNavigator(getIt()));
    getIt.registerSingleton<UserStore>(UserStore());
    getIt.registerSingleton<AuthRepository>(ApiAuthRepository(
      getIt(),
      getIt(),
    ));
    getIt.registerSingleton<AuthCubit>(AuthCubit(getIt(), getIt()));
    getIt.registerSingleton<BottomBarNavigator>(BottomBarNavigator(getIt()));
    getIt.registerSingleton<BottomBarCubit>(BottomBarCubit(getIt()));
  }
}

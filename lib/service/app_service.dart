import 'package:masla_bolo_app/data/auth/api_auth_repository.dart';
import 'package:masla_bolo_app/data/local_storage/primary_local_storage_repository.dart';
import 'package:masla_bolo_app/domain/repositories/auth_repository.dart';
import 'package:masla_bolo_app/domain/repositories/local_storage_repository.dart';
import 'package:masla_bolo_app/domain/stores/user_store.dart';
import 'package:masla_bolo_app/features/auth/auth_cubit.dart';
import 'package:masla_bolo_app/features/auth/auth_navigator.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_cubit.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_navigator.dart';
import 'package:masla_bolo_app/features/home/home_cubit.dart';
import 'package:masla_bolo_app/features/splash/splash_cubit.dart';
import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/features/splash/splash_navigator.dart';
import 'package:masla_bolo_app/network/network_repository.dart';
import 'package:masla_bolo_app/service/api_service.dart';
import 'package:get_it/get_it.dart';

class AppService {
  static Future<void> initialize(GetIt getIt) async {
    getIt.registerSingleton<AppNavigation>(AppNavigation());
    getIt.registerSingleton<SplashCubit>(SplashCubit(getIt(), getIt()));
    getIt.registerLazySingleton<LocalStorageRepository>(
      () => PrimaryLocalStorageRepository(),
    );
    getIt.registerLazySingleton<ApiService>(() => ApiService(getIt()));
    getIt.registerLazySingleton<NetworkRepository>(
        () => NetworkRepository(getIt()));
    getIt.registerLazySingleton<HomeCubit>(() => HomeCubit());
    getIt.registerLazySingleton<UserStore>(() => UserStore());
    getIt.registerLazySingleton<AuthRepository>(() => ApiAuthRepository(
          getIt(),
          getIt(),
        ));
    getIt.registerLazySingleton<AuthNavigator>(() => AuthNavigator(getIt()));
    getIt
        .registerLazySingleton<SplashNavigator>(() => SplashNavigator(getIt()));
    getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(getIt(), getIt()));
    getIt.registerLazySingleton<BottomBarNavigator>(() => BottomBarNavigator());
    getIt.registerLazySingleton<BottomBarCubit>(() => BottomBarCubit(getIt()));
  }
}

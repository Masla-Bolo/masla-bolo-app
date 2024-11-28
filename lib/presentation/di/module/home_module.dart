import '../../../di/service_locator.dart';
import '../../home/components/issue/issue_cubit.dart';
import '../../home/components/issue/issue_detail/issue_detail_cubit.dart';
import '../../home/components/issue/issue_detail/issue_detail_initial_params.dart';
import '../../home/components/issue/issue_detail/issue_detail_navigator.dart';
import '../../home/components/issue/issue_navigator.dart';

class HomeModule {
  static Future<void> configureLikeHomeModuleInjection() async {
    getIt.registerLazySingleton<IssueNavigator>(() => IssueNavigator(getIt()));
    getIt.registerLazySingleton<IssueCubit>(() => IssueCubit(
          getIt(),
          getIt(),
          getIt(),
          getIt(),
          getIt(),
          getIt(),
          getIt(),
        ));
    getIt.registerLazySingleton<IssueDetailNavigator>(
        () => IssueDetailNavigator(getIt()));
    getIt.registerFactoryParam<IssueDetailCubit, IssueDetailInitialParams,
        dynamic>(
      (params, _) => IssueDetailCubit(
        params,
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ),
    );
  }
}

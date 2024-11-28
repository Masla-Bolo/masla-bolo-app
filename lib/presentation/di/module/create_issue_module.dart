import '../../../di/service_locator.dart';
import '../../add_issue/create_issue_cubit.dart';
import '../../add_issue/create_issue_navigator.dart';

class CreateIssueModule {
  static Future<void> configureCreateIssueModuleInjection() async {
    getIt.registerLazySingleton<CreateIssueNavigator>(
        () => CreateIssueNavigator(getIt()));
    getIt.registerLazySingleton<CreateIssueCubit>(() => CreateIssueCubit(
          getIt(),
          getIt(),
          getIt(),
          getIt(),
          getIt(),
        ));
  }
}

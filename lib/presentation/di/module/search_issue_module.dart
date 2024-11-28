import '../../../di/service_locator.dart';
import '../../search_issue/search_issue_cubit.dart';
import '../../search_issue/search_issue_navigator.dart';

class SearchIssueModule {
  static Future<void> configureSearchIssueModuleInjection() async {
    getIt.registerSingleton<SearchIssueNavigator>(
      SearchIssueNavigator(getIt()),
    );
    getIt.registerSingleton<SearchIssueCubit>(
      SearchIssueCubit(
        getIt(),
        getIt(),
        getIt(),
      ),
    );
  }
}

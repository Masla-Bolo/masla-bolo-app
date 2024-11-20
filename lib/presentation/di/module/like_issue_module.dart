import '../../profile/components/settings/settings_sub_screens/like_issue/like_issue_navigator.dart';

import '../../../di/service_locator.dart';
import '../../profile/components/settings/settings_sub_screens/like_issue/like_issue_cubit.dart';

class LikeIssueModule {
  static Future<void> configureLikeIssueModuleInjection() async {
    getIt.registerSingleton<LikeIssueNavigator>(LikeIssueNavigator(getIt()));
    getIt.registerSingleton<LikeIssueCubit>(LikeIssueCubit(getIt(), getIt()));
  }
}

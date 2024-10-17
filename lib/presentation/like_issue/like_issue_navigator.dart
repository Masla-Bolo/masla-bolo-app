import '../home/components/issue/issue_detail/issue_detail_navigator.dart';
import '../../navigation/app_navigation.dart';
import '../../navigation/route_name.dart';

class LikeIssueNavigator with IssueDetailRoute {
  @override
  final AppNavigation navigation;

  LikeIssueNavigator(this.navigation);
}

mixin LikeIssueRoute {
  void goToLikeIssue() {
    navigation.pushReplacement(RouteName.likeIssue);
  }

  AppNavigation get navigation;
}

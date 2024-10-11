import 'package:masla_bolo_app/features/home/components/issue/issue_detail/issue_detail_navigator.dart';
import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';

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

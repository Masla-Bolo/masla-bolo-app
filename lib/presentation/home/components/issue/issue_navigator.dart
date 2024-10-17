import 'issue_detail/issue_detail_navigator.dart';
import '../../../notification/notification_navigator.dart';
import '../../../../navigation/app_navigation.dart';
import '../../../../navigation/route_name.dart';

class IssueNavigator with NotificationRoute, IssueDetailRoute {
  @override
  final AppNavigation navigation;

  IssueNavigator(this.navigation);

  pop() {
    navigation.pop();
  }
}

mixin HomeRoute {
  void goToHome() {
    navigation.push(RouteName.home);
  }

  AppNavigation get navigation;
}

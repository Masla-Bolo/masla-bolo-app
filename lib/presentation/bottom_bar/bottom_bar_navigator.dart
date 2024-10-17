import '../add_issue/create_issue_navigator.dart';
import '../../navigation/app_navigation.dart';
import '../../navigation/route_name.dart';

class BottomBarNavigator with CreateIssueRoute {
  @override
  final AppNavigation navigation;

  void exitApp() {
    navigation.exitApp();
  }

  BottomBarNavigator(this.navigation);
}

mixin BottomBarRoute {
  void goToBottomBar() {
    navigation.pushReplacement(RouteName.bottomBar);
  }

  AppNavigation get navigation;
}

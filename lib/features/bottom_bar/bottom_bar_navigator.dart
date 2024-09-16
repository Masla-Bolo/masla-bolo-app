import 'package:masla_bolo_app/features/issue/issue_navigator.dart';
import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';

class BottomBarNavigator with IssueRoute {
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

import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';

class IssueNavigator {
  final AppNavigation navigation;
  pop() {
    navigation.pop();
  }

  IssueNavigator(this.navigation);
}

mixin IssueRoute {
  AppNavigation get navigation;

  void goToIssue() => navigation.push(RouteName.issue);
}

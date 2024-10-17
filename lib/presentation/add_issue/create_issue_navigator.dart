import '../../navigation/app_navigation.dart';
import '../../navigation/route_name.dart';

class CreateIssueNavigator {
  final AppNavigation navigation;
  pop() {
    navigation.pop();
  }

  CreateIssueNavigator(this.navigation);
}

mixin CreateIssueRoute {
  AppNavigation get navigation;

  void goToIssue() => navigation.push(RouteName.issue);
}

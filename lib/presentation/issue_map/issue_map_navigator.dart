import 'package:masla_bolo_app/navigation/route_name.dart';
import 'package:masla_bolo_app/presentation/home/components/issue/issue_detail/issue_detail_navigator.dart';
import '../../navigation/app_navigation.dart';
import '../search_issue/search_issue_navigator.dart';

class IssueMapNavigator with SearchIssueRoute, IssueDetailRoute {
  @override
  final AppNavigation navigation;
  IssueMapNavigator(this.navigation);

  void pop() => navigation.pop();
}

mixin IssueMapRoute {
  void goToIssueMap() {
    navigation.push(RouteName.issueMap);
  }

  AppNavigation get navigation;
}

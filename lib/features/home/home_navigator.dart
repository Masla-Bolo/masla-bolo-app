import 'package:masla_bolo_app/features/home/components/issue_detail/issue_detail_navigator.dart';
import 'package:masla_bolo_app/features/notification/notification_navigator.dart';
import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';

class HomeNavigator with NotificationRoute, IssueDetailRoute {
  @override
  final AppNavigation navigation;

  HomeNavigator(this.navigation);

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

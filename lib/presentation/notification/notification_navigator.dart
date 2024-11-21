import '../../navigation/app_navigation.dart';
import '../../navigation/route_name.dart';

class NotificationNavigator {
  // @override
  final AppNavigation navigation;

  NotificationNavigator(this.navigation);

  void pop() {
    navigation.pop();
  }

  void push(String routeName, Map<String, dynamic>? args) {
    navigation.push(routeName, arguments: args);
  }
}

mixin NotificationRoute {
  void goToNotification() => navigation.push(RouteName.notification);
  AppNavigation get navigation;
}

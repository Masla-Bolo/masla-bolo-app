import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';

class NotificationNavigator {
  // @override
  final AppNavigation navigation;

  NotificationNavigator(this.navigation);

  void pop() {
    navigation.pop();
  }
}

mixin NotificationRoute {
  void goToNotification() => navigation.push(RouteName.notification);
  AppNavigation get navigation;
}

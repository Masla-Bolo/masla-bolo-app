import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';

class NotificationNavigator {}

mixin NotificationRoute {
  void goToNotification() => navigation.push(RouteName.notification);
  AppNavigation get navigation;
}

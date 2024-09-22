import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_navigator.dart';
import 'package:masla_bolo_app/features/get_started/get_started_navigator.dart';
import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';

class AuthNavigator with BottomBarRoute, AuthRoute, GetStartedRoute {
  AuthNavigator(this.navigation);
  @override
  final AppNavigation navigation;

  pop() {
    navigation.pop();
  }
}

mixin AuthRoute {
  void goToLogin() {
    navigation.pushReplacement(RouteName.login);
  }

  void goToRegister() {
    navigation.pushReplacement(RouteName.register);
  }

  AppNavigation get navigation;
}

import 'package:masla_bolo_app/features/auth/auth_navigator.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_navigator.dart';
import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';

class GetStartedNavigator with AuthRoute, BottomBarRoute {
  @override
  final AppNavigation navigation;

  GetStartedNavigator(this.navigation);

  exitApp() {
    navigation.exitApp();
  }
}

mixin GetStartedRoute {
  AppNavigation get navigation;

  goToGetStarted() => navigation.pushReplacement(RouteName.getStarted);
}

import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';

class ExploreNavigator {
  // @override
  final AppNavigation navigation;

  ExploreNavigator(this.navigation);
}

mixin ExploreRoute {
  void goToExplore() {
    navigation.pushReplacement(RouteName.explore);
  }

  AppNavigation get navigation;
}

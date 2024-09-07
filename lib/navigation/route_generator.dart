import 'package:masla_bolo_app/features/auth/register/resgister_screen.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar.dart';
import 'package:masla_bolo_app/features/notification/notification_page.dart';
import 'package:masla_bolo_app/features/profile/profile_screen.dart';
import 'package:masla_bolo_app/main.dart';
import 'package:flutter/material.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';

import '../features/auth/login/login_screen.dart';
import '../features/home/home_screen.dart';
import '../features/splash/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // final args =
  //     (settings.arguments ?? <String, dynamic>{}) as Map<String, dynamic>;
  switch (settings.name) {
    case RouteName.splash:
      return MaterialPageRoute(
          builder: (context) => SplashScreen(
                cubit: getIt(),
              ));

    case RouteName.login:
      return MaterialPageRoute(
          builder: (context) => LoginScreen(
                cubit: getIt(),
              ));

    case RouteName.bottomBar:
      return MaterialPageRoute(
          builder: (context) => BottomBar(
                cubit: getIt(),
              ));
    case RouteName.register:
      return MaterialPageRoute(builder: (context) => const ResgisterScreen());

    case RouteName.profile:
      return MaterialPageRoute(builder: (context) => const ProfileScreen());

    case RouteName.home:
      return MaterialPageRoute(
          builder: (context) => HomeScreen(cubit: getIt()));

    case RouteName.notification:
      return MaterialPageRoute(builder: (context) => const NotificationPage());

    case RouteName.settings:
      return MaterialPageRoute(builder: (context) => const ProfileScreen());

    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: Center(
                  child: Text('PAGE NOT FOUND!!'),
                ),
              ));
  }
}

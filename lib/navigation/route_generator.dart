// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';
import 'package:masla_bolo_app/presentation/add_issue/create_issue_screen.dart';
import 'package:masla_bolo_app/presentation/auth/sign_up/sign_up_screen.dart';
import 'package:masla_bolo_app/presentation/auth/verify_email/verify_email.dart';
import 'package:masla_bolo_app/presentation/bottom_bar/bottom_bar.dart';
import 'package:masla_bolo_app/presentation/get_started/get_started_screen.dart';
import 'package:masla_bolo_app/presentation/home/components/issue/issue_detail/issue_detail.dart';
import 'package:masla_bolo_app/presentation/like_issue/like_issue_page.dart';
import 'package:masla_bolo_app/presentation/notification/notification_page.dart';
import 'package:masla_bolo_app/presentation/profile/components/edit_profile.dart';
import 'package:masla_bolo_app/presentation/profile/components/settings/settings_page.dart';
import 'package:masla_bolo_app/presentation/profile/components/settings/settings_sub_screens/about/about_us.dart';
import 'package:masla_bolo_app/presentation/profile/components/settings/settings_sub_screens/contact/contact_us.dart';
import 'package:masla_bolo_app/presentation/profile/components/settings/settings_sub_screens/developers/developers.dart';
import 'package:masla_bolo_app/presentation/profile/components/settings/settings_sub_screens/notification_settings/app_notification_settings.dart';
import 'package:masla_bolo_app/presentation/profile/components/settings/settings_sub_screens/privacy_policy/privacy_policy.dart';
import 'package:masla_bolo_app/presentation/profile/components/settings/settings_sub_screens/support_us/support_us.dart';
import 'package:masla_bolo_app/presentation/profile/profile_screen.dart';

import '../di/service_locator.dart';
import '../presentation/auth/login/login_screen.dart';
import '../presentation/home/home_screen.dart';
import '../presentation/splash/splash_screen.dart';

enum TransitionType {
  fade,
  slide,
}

Route<dynamic> generateRoute(RouteSettings settings) {
  final args =
      (settings.arguments ?? <String, dynamic>{}) as Map<String, dynamic>;

  switch (settings.name) {
    case RouteName.splash:
      return getRoute(const SplashScreen(), TransitionType.fade);

    case RouteName.login:
      return getRoute(const LoginScreen(), TransitionType.fade);

    case RouteName.bottomBar:
      return getRoute(BottomBar(cubit: getIt()), TransitionType.fade);

    case RouteName.register:
      return getRoute(const SignUpScreen(), TransitionType.fade);

    case RouteName.emailVerify:
      return getRoute(VerifyEmail(email: args["email"]), TransitionType.slide);

    case RouteName.profile:
      return getRoute(const ProfileScreen(), TransitionType.fade);

    case RouteName.editProfile:
      return getRoute(const EditProfile(), TransitionType.slide);

    case RouteName.home:
      return getRoute(const HomeScreen(), TransitionType.slide);

    case RouteName.notification:
      return getRoute(const NotificationPage(), TransitionType.fade);

    case RouteName.likeIssue:
      return getRoute(const LikeIssuePage(), TransitionType.fade);

    case RouteName.issue:
      return getRoute(const CreateIssueScreen(), TransitionType.fade);

    case RouteName.issueDetail:
      return getRoute(
          IssueDetail(
            cubit: getIt(
              param1: args["params"],
            ),
          ),
          TransitionType.slide);

    case RouteName.getStarted:
      return getRoute(const GetStartedScreen(), TransitionType.fade);

    case RouteName.settings:
      return getRoute(const SettingsPage(), TransitionType.slide);

    case RouteName.aboutUs:
      return getRoute(const AboutUs(), TransitionType.slide);

    case RouteName.contactUs:
      return getRoute(const ContactUs(), TransitionType.slide);

    case RouteName.supportUs:
      return getRoute(const SupportUs(), TransitionType.slide);

    case RouteName.notificationSettings:
      return getRoute(const AppNotificationSettings(), TransitionType.slide);

    case RouteName.privacyPolicy:
      return getRoute(const PrivacyPolicy(), TransitionType.slide);

    case RouteName.developers:
      return getRoute(const Developers(), TransitionType.slide);

    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text('PAGE NOT FOUND!!')),
        ),
      );
  }
}

PageRouteBuilder getRoute(Widget page, TransitionType transitionType) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (transitionType) {
        case TransitionType.fade:
          return FadeTransition(opacity: animation, child: child);
        case TransitionType.slide:
          const begin = Offset(1, 0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
      }
    },
  );
}

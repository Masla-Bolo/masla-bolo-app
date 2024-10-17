import 'package:masla_bolo_app/features/di/module/bottom_bar_module.dart';
import 'package:masla_bolo_app/features/di/module/create_issue_module.dart';
import 'package:masla_bolo_app/features/di/module/get_started_module.dart';
import 'package:masla_bolo_app/features/di/module/home_module.dart';
import 'package:masla_bolo_app/features/di/module/like_issue_module.dart';
import 'package:masla_bolo_app/features/di/module/notification_module.dart';
import 'package:masla_bolo_app/features/di/module/profle_module.dart';
import 'package:masla_bolo_app/features/di/module/splash_module.dart';

import 'module/presentation_auth_module.dart';

class PresentationLayerInjection {
  static Future<void> configurePresentationLayerInjection() async {
    await SplashModule.configureSplashModuleInjection();
    await PresentationAuthModule.configurePresentaionAuthModuleInjection();
    await GetStartedModule.configureGetStartedModuleInjection();
    await BottomBarModule.configureBottomBarModuleInjection();
    await HomeModule.configureLikeHomeModuleInjection();
    await LikeIssueModule.configureLikeIssueModuleInjection();
    await CreateIssueModule.configureCreateIssueModuleInjection();
    await ProfileModule.configureProfileModuleInjection();
    await NotificationModule.configureNotificationModuleInjection();
  }
}

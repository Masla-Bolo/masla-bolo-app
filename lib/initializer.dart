import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'di/service_locator.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'service/notification_service.dart';

class Initializer {
  static Future<void> initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await setPreferredOrientations();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await ServiceLocator.configureServiceLocator();
    FirebaseMessaging.onBackgroundMessage(
      NotificationService.handleBackgroundMessage,
    );
  }

  static Future<void> setPreferredOrientations() {
    return SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }
}

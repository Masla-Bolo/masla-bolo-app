import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:masla_bolo_app/di/service_locator.dart';
import 'package:masla_bolo_app/domain/model/notification_json.dart';
import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/network/network_repository.dart';
import 'package:masla_bolo_app/presentation/home/components/issue/issue_detail/issue_detail_initial_params.dart';
import 'package:masla_bolo_app/presentation/notification/notification_cubit.dart';

import '../navigation/route_name.dart';

class NotificationService {
  final AppNavigation navigation;
  final NetworkRepository networkRepository;

  NotificationService(this.navigation, this.networkRepository);

  final fcm = FirebaseMessaging.instance;

  Future<void> requestPermission() async {
    NotificationSettings settings = await fcm.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log("User granted provisional permission");
    } else {
      log("User declined or has not accepted permission");
    }
  }

  Future<void> initNotifications({bool callFcm = false}) async {
    List<Future> futures = [
      handleForegroundNotification(),
      handleBackgroundNotificationClick(),
      handleTerminatedNotificationClick(),
      if (callFcm) sendTokenToServer(),
    ];
    Future.wait(futures);
  }

  Future<void> handleForegroundNotification() async {
    log("FOREGROUND LISTENER INITIALIZED");
    FirebaseMessaging.onMessage.listen(
      handleMessage,
      onError: (obj) {
        log("Error handling foreground notification: ${obj.toString()}");
      },
      onDone: () {
        log("Foreground notification listener done");
      },
    );
  }

  Future<void> sendTokenToServer() async {
    try {
      String? firebaseMessagingToken = await fcm.getToken();
      log("firebaseMessagingToken: $firebaseMessagingToken");
      if (firebaseMessagingToken != null) {
        await networkRepository.patch(url: "/users/fcmtoken/", data: {
          "token": firebaseMessagingToken,
        });
      }
    } catch (e) {
      log("Failed to send FCM token to server: $e");
    }
  }

  Future<void> handleMessage(RemoteMessage? message) async {
    log("Foreground Notification Received");
    if (message == null) return;
    if (message.notification != null) {
      log("Message Title: ${message.notification?.title}");
      log("Message Body: ${message.notification?.body}");
      addNotification(message);
    }
    log("Full message data: ${message.data}");
  }

  static void addNotification(RemoteMessage? message) {
    if (message?.data != null) {
      var notification =
          NotificationJson.fromJson(message?.data ?? {}).toDomain();
      notification.isNew = true;
      getIt<NotificationCubit>().addNotification(notification);
    }
  }

  Future<void> handleTerminatedNotificationClick() async {
    log("TERMINATED LISTENER INITIALIZED");
    await fcm.getInitialMessage().then((message) {
      log("App Terminated Notification Received");
      if (message != null) {
        log("Message Title: ${message.notification?.title}");
        log("Message Body: ${message.notification?.body}");
        log("Full message data: ${message.data}");
        addNotification(message);
        _navigateBasedOnMessageType(message);
      }
    });
  }

  Future<void> handleBackgroundNotificationClick() async {
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessageOpen);
  }

  static Future<void> handleBackgroundMessage(RemoteMessage? message) async {
    log("BACKGROUND LISTENER INITIALIZED");
    if (message == null) return;
    if (message.notification != null) {
      log("Background Message Title: ${message.notification?.title}");
      log("Background Message Body: ${message.notification?.body}");
      addNotification(message);
    }
    log("Background message data: ${message.data}");
  }

  void handleMessageOpen(RemoteMessage? message) {
    log("Background Notification Click Received");
    if (message == null) return;
    if (message.notification != null) {
      log("Message Title: ${message.notification?.title}");
      log("Message Body: ${message.notification?.body}");
      _navigateBasedOnMessageType(message);
    }
  }

  void _navigateBasedOnMessageType(RemoteMessage message) {
    final screen = getScreenType(message.data);
    navigation.push(screen.$1, arguments: screen.$2);
  }

  static (String, Map<String, dynamic>?) getScreenType(
    Map<String, dynamic>? message,
  ) {
    final screen = message?["screen"] ?? "";
    switch (screen) {
      case "issueDetail":
        final issuedId =
            int.tryParse(message?["screen_id"].toString() ?? "") ?? 0;
        return (
          RouteName.issueDetail,
          {"params": IssueDetailInitialParams(issueId: issuedId)}
        );
      default:
        return (RouteName.settings, {});
    }
  }
}

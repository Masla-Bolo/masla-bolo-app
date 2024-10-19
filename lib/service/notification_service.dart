import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';
import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/network/network_repository.dart';

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

  Future<void> initNotifications() async {
    await requestPermission();
    await sendTokenToServer();
    Future.wait([
      handleForegroundNotification(),
      handleBackgroundNotificationClick(),
      handleTerminatedNotificationClick(),
    ]);
  }

  Future<void> handleForegroundNotification() async {
    FirebaseMessaging.onMessage.listen(handleMessage);
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
      showToast(
        "${message.notification?.title}",
        params: ToastParam(
          toastAlignment: Alignment.bottomCenter,
        ),
      );
    }
    log("Full message data: ${message.data}");
  }

  Future<void> handleBackgroundNotificationClick() async {
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessageOpen);
  }

  Future<void> handleTerminatedNotificationClick() async {
    await FirebaseMessaging.instance.getInitialMessage().then((message) {
      log("App Terminated Notification Received");
      if (message != null) {
        log("Message Title: ${message.notification?.title}");
        log("Message Body: ${message.notification?.body}");
        log("Full message data: ${message.data}");
        _navigateBasedOnMessageType(message);
      }
    });
  }

  static Future<void> handleBackgroundMessage(RemoteMessage? message) async {
    if (message == null) return;
    if (message.notification != null) {
      log("Background Message Title: ${message.notification?.title}");
      log("Background Message Body: ${message.notification?.body}");
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
    switch (message.data["type"]) {
      case "notification":
        navigation.push(RouteName.notification, arguments: message);
        break;
      case "issueDetail":
        navigation.push(RouteName.issueDetail, arguments: message);
        break;
      default:
        log("Unknown notification type: ${message.data["type"]}");
    }
  }
}

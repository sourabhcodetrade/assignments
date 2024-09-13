import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mvc/app/utils/routes/routes.dart';
import 'package:mvc/main.dart';

class NotificationController {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //initialization
  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    //for ios macOS
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => () {},
    );
    // for linux
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');

    //
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        log("dfghjk;");
      },
    );
  }

  @pragma('vm:entry-point')
  static void notificationTapBackground(
      NotificationResponse notificationResponse) {
    // handle action
  }

  static void openPage(String value) {
    switch (value) {
      case 'list':
        if (!checkCurrentScreen(Routes.listScreen)) {
          Navigator.pushNamed(
              navigatorKey.currentState!.context, Routes.listScreen);
        }
        break;
      case 'home':
        if (!checkCurrentScreen(Routes.homeScreen)) {
          Navigator.pushNamed(
              navigatorKey.currentState!.context, Routes.listScreen);
        }
        break;
      case 'setting':
        if (!checkCurrentScreen(Routes.settingsScreen)) {
          Navigator.pushNamed(
              navigatorKey.currentState!.context, Routes.listScreen);
        }
        break;
      case 'singnup':
        if (!checkCurrentScreen(Routes.signupScreen)) {
          Navigator.pushNamed(
              navigatorKey.currentState!.context, Routes.listScreen);
        }
        break;
      case 'login':
        if (!checkCurrentScreen(Routes.loginScreen)) {
          Navigator.pushNamed(
              navigatorKey.currentState!.context, Routes.listScreen);
        }
        break;
    }
  }

  static checkCurrentScreen(String route) {
    final navigator = navigatorKey.currentState!;
    if (navigator.canPop()) {
      final currentRoute = ModalRoute.of(navigator.context)!;
      return currentRoute.settings.name == route;
    }
    return false;
  }

  //show a simple Notification
  static Future showSimpleNotification({
    required String? title,
    required String? body,
    required Map<String, dynamic>? payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('basic_channel', 'Basic Channel',
            channelDescription: 'testing',
            importance: Importance.max,
            priority: Priority.high,
            color: Colors.red,
            category: AndroidNotificationCategory.message,
            chronometerCountDown: true,
            enableVibration: true,
            enableLights: true,
            playSound: true,
            visibility: NotificationVisibility.public,
            actions: [
              AndroidNotificationAction(
                '1',
                'Reply',
                titleColor: Colors.red,
              ),
            ],
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        1, title, body, notificationDetails,
        payload: payload!['key'].toString());
  }
}
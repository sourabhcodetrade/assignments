// ignore_for_file: depend_on_referenced_packages

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:flutter/material.dart';
import 'package:mvc/main.dart';

import '../utils/routes/routes.dart';

class NotificationsController {
  static Future<void> init() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelGroupKey: 'firebase_channel_group',
            channelKey: 'firebase_channel',
            channelName: 'firebase notifications',
            channelDescription: 'firebase Notification channel for basic tests',
            defaultColor: const Color(0xFF9D50DD),
            playSound: true,
            importance: NotificationImportance.Max,
            criticalAlerts: true,
            enableVibration: true,
            ledColor: Colors.yellow),
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'firebase_channel_group',
            channelGroupName: 'firebase group'),
      ],
    );
  }

  static Future<void> initializeRemoteNotifications() async {
    await AwesomeNotificationsFcm().initialize(
        onFcmSilentDataHandle: NotificationsController.mySilentDataHandle,
        onFcmTokenHandle: NotificationsController.myFcmTokenHandle,
        onNativeTokenHandle: NotificationsController.myNativeTokenHandle);
  }

  static Future<void> reqPermission() async {
    bool isAllowedToSendNotification =
        await AwesomeNotifications().isNotificationAllowed();

    if (!isAllowedToSendNotification) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    Map<String, dynamic>? payload = receivedAction.payload;
    if (payload != null) {
      // print('Received payload data: ${payload['type']}');
      openPage(payload['type']);
    }
  }

  @pragma("vm:entry-point")
  static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
    // print('"SilentData": ${silentData.toString()}');

    if (silentData.createdLifeCycle != NotificationLifeCycle.Foreground) {
      // print("bg");
    } else {
      // print("FOREGROUND");
    }
  }

  @pragma("vm:entry-point")
  static Future<void> myFcmTokenHandle(String token) async {
    // print('FCM Token:"$token"');
  }

  /// Use this method to detect when a new native token is received
  @pragma("vm:entry-point")
  static Future<void> myNativeTokenHandle(String token) async {
    // print('Native Token:"$token"');
  }

  static void openPage(String value) {
    switch (value) {
      case 'list':
        checkCurrentScreen(Routes.listScreen)
            ? null
            : Navigator.pushNamed(
                navigatorKey.currentState!.context, Routes.listScreen);
        break;
      case 'login':
        checkCurrentScreen(Routes.loginScreen)
            ? null
            : Navigator.pushNamed(
                navigatorKey.currentState!.context, Routes.loginScreen);
        break;
      case 'signup':
        checkCurrentScreen(Routes.signupScreen)
            ? null
            : Navigator.pushNamed(
                navigatorKey.currentState!.context, Routes.signupScreen);
        break;
      case 'setting':
        checkCurrentScreen(Routes.settingsScreen)
            ? null
            : Navigator.pushNamed(
                navigatorKey.currentState!.context, Routes.settingsScreen);
        break;
      case 'home':
        checkCurrentScreen(Routes.homeScreen)
            ? null
            : Navigator.pushNamed(
                navigatorKey.currentState!.context, Routes.homeScreen);
        break;
    }
  }

  static checkCurrentScreen(String route) {
    return Navigator.of(navigatorKey.currentState!.context).isCurrent(route);
  }
}

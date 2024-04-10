// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

class LocalNotification {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final onCLickNotification = BehaviorSubject<String>();

  static void onNotificationTap(NotificationResponse response) {
    onCLickNotification.add(response.payload!);
  }

  //initialization
  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    //for ios macOS
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => null,
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
      onDidReceiveNotificationResponse: (details) => onNotificationTap,
    );
  }

  //show a simple Notification
  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
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
    await flutterLocalNotificationsPlugin
        .show(1, title, body, notificationDetails, payload: payload);
  }

  static Future showScheduledNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    tz.initializeTimeZones();
    var localTimeZone = tz.local;
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('basic_channel_2', 'Basic Channel',
            channelDescription: 'testing',
            importance: Importance.max,
            priority: Priority.high,
            color: Colors.green,
            ticker: 'ticker');

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      title,
      body,
      tz.TZDateTime.now(localTimeZone).add(const Duration(seconds: 5)),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future showPeriodicNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('basic_channel_3', 'Basic Channel',
            channelDescription: 'testing',
            importance: Importance.max,
            priority: Priority.high,
            color: Colors.green,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.periodicallyShow(
      3,
      title,
      body,
      RepeatInterval.everyMinute,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      payload: payload,
    );
  }

  static cancel(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

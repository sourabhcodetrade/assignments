import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:local_notification/controller/firebase_controller.dart';
import 'package:local_notification/view/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    Platform.isAndroid
        ? await Firebase.initializeApp(
            options: const FirebaseOptions(
                apiKey: 'AIzaSyCLPeKwY_udHflTeSWTBhUPPS2Vb0dNbR4',
                appId: '1:288608950818:android:e67c0597b207b8b09f487b',
                messagingSenderId: '288608950818',
                projectId: 'awesome-notification-8f48f'),
          )
        : await Firebase.initializeApp();

    // FirebaseController.initFirebaseMessaging();
    // FirebaseMessaging.onMessage
    //     .listen((event) => FirebaseController.fireBaseForegroundMessageHandler(event));
    // FirebaseMessaging.onBackgroundMessage(
    //   (message) => FirebaseController.fireBaseMessageHandler(message),
    // );

    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: const Color(0xFF9D50DD),
            ledColor: Colors.white),
        NotificationChannel(
            channelGroupKey: 'firebase_channel_group',
            channelKey: 'firebase_channel',
            channelName: 'firebase notifications',
            channelDescription: 'firebase Notification channel for basic tests',
            defaultColor: const Color(0xFF9D50DD),
            ledColor: Colors.yellow),
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'basic group'),
        NotificationChannelGroup(
            channelGroupKey: 'firebase_channel_group',
            channelGroupName: 'firebase group'),
      ],
    );
  } catch (e) {
    debugPrint(e.toString());
    print('error$e');
  }

  bool isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();

  if (!isAllowedToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

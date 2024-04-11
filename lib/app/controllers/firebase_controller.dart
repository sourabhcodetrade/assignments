import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mvc/app/controllers/notification_controller.dart';

Future<void> handleBackgroudMessage(RemoteMessage message) async {
  // print('working');
  // print('title ${message.notification!.title}');
  // print('body ${message.notification!.body}');
  // print('payload ${message.data}');
  NotificationController.showSimpleNotification(
      title: message.notification?.title,
      body: message.notification!.body,
      payload: message.data);
}

Future<void> handleForegroudMessage(RemoteMessage message) async {
  NotificationController.showSimpleNotification(
      title: message.notification?.title,
      body: message.notification!.body,
      payload: message.data);
}

class FirebaseController {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCmToken = await _firebaseMessaging.getToken();
    debugPrint('Device token= $fCmToken');
    FirebaseMessaging.onMessage.listen(
      (message) => handleForegroudMessage(message),
    );
    FirebaseMessaging.onBackgroundMessage(
      (message) => handleBackgroudMessage(message),
    );
  }
}

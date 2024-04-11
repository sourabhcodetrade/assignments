import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseController {
  static Future<void> fireBaseMessageHandler(RemoteMessage message) async {

    await AwesomeNotifications().createNotificationFromJsonData(message.data);
  }

  static Future<void> fireBaseForegroundMessageHandler(
      RemoteMessage message) async {
    try {

      // showDialog(
      //   context: context,
      //   builder: (context) => AlertDialog(
      //     content: ListTile(
      //       title: Text(message.data['notification']['title']),
      //       subtitle: Text(message.data['notification']['body']),
      //     ),
      //     actions: <Widget>[
      //       ElevatedButton(
      //         child: Text('Ok'),
      //         onPressed: () => Navigator.of(context).pop(),
      //       ),
      //     ],
      //   ),
      // );
    } catch (e) {
    }
  }

  static Future initFirebaseMessaging() async {
    await FirebaseMessaging.instance.requestPermission(
      sound: true,
      alert: true,
      announcement: true,
    );

    final token = await FirebaseMessaging.instance.getToken();
  }
}

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseController {
  static Future<void> fireBaseMessageHandler(RemoteMessage message) async {
    print('Custom Push Notification from Firebase ${message.data}');

    await AwesomeNotifications().createNotificationFromJsonData(message.data);
  }

  static Future<void> fireBaseForegroundMessageHandler(
      RemoteMessage message) async {
    print('Foreground Push Notification from Firebase ${message.data}');

    await AwesomeNotifications().createNotificationFromJsonData(message.data);
    print('method completed');
  }

  static Future initFirebaseMessaging() async {
    await FirebaseMessaging.instance.requestPermission(
      sound: true,
      alert: true,
      announcement: true,
    );

    final token = await FirebaseMessaging.instance.getToken();
    print('device = $token');
  }
}

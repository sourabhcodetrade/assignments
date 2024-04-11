import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mvc/app/controllers/notification_controller.dart';

Future<void> handleBackgroudMessage(RemoteMessage message) async {
  print('working');
  print('title ${message.notification!.title}');
  print('body ${message.notification!.body}');
  print('payload ${message.data}');
  // final Title = message.notification.title;
  NotificationController.showSimpleNotification(title: message.notification?.title, body: message.notification!.body, payload: null);
}

class FirebaseController {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCmToken = await _firebaseMessaging.getToken();
    print('Device token= $fCmToken');
    FirebaseMessaging.onBackgroundMessage(
      (message) => handleBackgroudMessage(message),
    );
  }
}

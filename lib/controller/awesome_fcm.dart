import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';

import 'notification_controller.dart';

class AwesomeFCMController {
  static Future<void> initializeRemoteNotifications() async {
    await AwesomeNotificationsFcm().initialize(
        onFcmSilentDataHandle: NotificationsController.mySilentDataHandle,
        onFcmTokenHandle: NotificationsController.myFcmTokenHandle,
        onNativeTokenHandle: NotificationsController.myNativeTokenHandle);
  }
}

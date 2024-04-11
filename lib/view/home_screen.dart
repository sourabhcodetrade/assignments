import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:local_notification/controller/notification_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String localTimeZone;
  late String utcTimeZone;
  @override
  void initState() {
    getTimeZone();
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationsController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationsController.onNotificationCreatedMethod,
      onDismissActionReceivedMethod:
          NotificationsController.onDismissActionReceivedMethod,
      onNotificationDisplayedMethod:
          NotificationsController.onNotificationDisplayedMethod,
    );
    super.initState();
  }

  getTimeZone() async {
    localTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    utcTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                AwesomeNotifications().createNotification(
                  content: NotificationContent(
                    id: 1,
                    channelKey: "basic_channel",
                    title: 'Awesome Notification',
                    body: 'Hello i am a Notification',
                    displayOnForeground: true,
                    notificationLayout: NotificationLayout.Messaging,
                    payload: {'name': 'hello'},
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.teal),
              ),
              child: const Text(
                'Simple notification',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                AwesomeNotifications().createNotification(
                    content: NotificationContent(
                      id: 2,
                      channelKey: 'basic_channel',
                      title: 'Wait 5 seconds to show',
                      body: 'Now it is 5 seconds later.',
                      wakeUpScreen: true,
                      category: NotificationCategory.Alarm,
                    ),
                    schedule: NotificationInterval(
                      interval: 5,
                      timeZone: localTimeZone,
                    ));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.teal),
              ),
              child: const Text(
                'Interval notification',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                AwesomeNotifications().createNotification(
                    content: NotificationContent(
                      id: 3,
                      channelKey: 'basic_channel',
                      title: 'Notification at exactly every single minute',
                      body:
                          'This notification was schedule to repeat at every single minute at clock.',
                      notificationLayout: NotificationLayout.Default,
                    ),
                    schedule: NotificationCalendar(
                        second: 0, timeZone: localTimeZone, repeats: true));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.teal),
              ),
              child: const Text(
                'Calendar notification',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                AwesomeNotifications().createNotification(
                    content: NotificationContent(
                  id: 4,
                  channelKey: 'basic_channel',
                  title:
                      'Emojis are awesome too! ${Emojis.smile_face_with_tongue}${Emojis.smile_rolling_on_the_floor_laughing}${Emojis.emotion_red_heart}',
                  body:
                      'Simple body with a bunch of Emojis! ${Emojis.transport_police_car} ${Emojis.animals_dog} ${Emojis.flag_UnitedStates} ${Emojis.person_baby}',
                  bigPicture:
                      'https://tecnoblog.net/wp-content/uploads/2019/09/emoji.jpg',
                  notificationLayout: NotificationLayout.BigPicture,
                ));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.teal),
              ),
              child: const Text(
                'Emoji notification',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                AwesomeNotifications().cancelAll();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.teal),
              ),
              child: const Text(
                'Cancel all notification',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                AwesomeNotifications().cancelAllSchedules();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.teal),
              ),
              child: const Text(
                'Cancel all Scheduled notification',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// NotificationContent (
// id: int,
// channelKey: String,
// title: String?,
// body: String?,
// summary: String?,
// category: NotificationCategory?,
// badge: int?,
// showWhen: bool?,
// displayOnForeground: bool?,
// displayOnBackground: bool?,
// icon: String?,
// largeIcon: String?,
// bigPicture: String?,
// autoDismissible: bool?,
// chronometer: Duration?,
// timeoutAfter: Duration?,
// color: Color?,
// backgroundColor: Color?,
// payload: Map<String, String>?,
// notificationLayout: NotificationLayout?,
// hideLargeIconOnExpand: bool?,
// locked: bool?,
// progress: double?,
// ticker: String?,
// actionType: ActionType?
// )

import 'package:flutter/material.dart';
import 'package:flutter_local/local_notification.dart';
import 'package:flutter_local/result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    listenToNotification();
    super.initState();
  }

  listenToNotification() {
    print("listening");
    LocalNotification.onCLickNotification.stream.listen((event) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              payload: event,
            ),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                LocalNotification.showSimpleNotification(
                    title: "Local Notify",
                    body: "Hello i am Notification",
                    payload: "Simple Notification Tapped");
              },
              style: const ButtonStyle(
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
                LocalNotification.showScheduledNotification(
                  title: "Scheduled notifi",
                  body: "Hello i am Scheduled +Notification",
                  payload: "Scheduled Notification Tapped",
                );
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.teal),
              ),
              child: const Text(
                'Scheduled notification',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                LocalNotification.showPeriodicNotification(
                  title: "Periodic notify",
                  body: "Hello i am Periodic +Notification",
                  payload: "Period Notification Tapped",
                );
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.teal),
              ),
              child: const Text(
                'Periodic notification',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                LocalNotification.cancel(1);
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.teal),
              ),
              child: const Text(
                'cancel notifcation id 1',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                LocalNotification.cancel(2);
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.teal),
              ),
              child: const Text(
                'cancel notifcation id 2',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                LocalNotification.cancel(3);
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.teal),
              ),
              child: const Text(
                'cancel notifcation id 3',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                LocalNotification.cancelAll();
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.teal),
              ),
              child: const Text(
                'Cancel All',
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

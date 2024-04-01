import 'package:flutter/material.dart';
import 'package:navigatorobserver/nav_observer.dart';
import 'first_screen.dart';
import 'second_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorObservers: [MyNavigatorObserver()],
        initialRoute: '/',
        routes: {
          '/': (context) => const FirstScreen(),
          '/second': (context) => const SecondScreen(),
        });
  }
}

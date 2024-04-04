import 'package:flutter/material.dart';
import 'package:navigationsmethod/routes.dart';
import 'package:navigationsmethod/screen.dart';

void main() {
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
      initialRoute: Routes.screen1,
      routes: {
        Routes.screen1: (context) => const Screen1(),
        Routes.screen2: (context) => const Screen2(),
        Routes.screen3: (context) => const Screen3(),
      },
    );
  }
}



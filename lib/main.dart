import 'package:flutter/material.dart';
import 'package:socketexample/utils/routes.dart';
import 'package:socketexample/view/splash_screen.dart';
import 'package:socketexample/view/welcome_screen.dart';
import 'view/chat_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        Routes.splashScreen: (context) =>  SplashScreen(),
        Routes.welcomeScreen: (context) =>  WelcomeScreen(),
        Routes.chatScreen: (context) => const ChatScreen(),

      },
      initialRoute: Routes.splashScreen,
    );
  }
}


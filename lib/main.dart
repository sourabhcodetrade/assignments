import 'package:agora_ui_kit_integration/utils/routes.dart';
import 'package:agora_ui_kit_integration/view/home_screen.dart';
import 'package:agora_ui_kit_integration/view/video_call_screen.dart';
import 'package:flutter/material.dart';

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
      initialRoute: Routes.homeScreen,
      routes: {
        Routes.homeScreen: (context) => const HomeScreen(),
        Routes.videoCallScreen: (context) => const VideoCallScreen(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:untitled/navigation_manager.dart';
import 'home_screen.dart';

void main() {
  runApp( const MainApp());
}


class MainApp extends StatelessWidget {

   const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      home: const HomeScreen(),
      title: "Permission Manager",
      navigatorKey: NavigationManager.navigatorKey,


    );
  }
}




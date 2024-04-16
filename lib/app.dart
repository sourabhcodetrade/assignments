import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final String title;
  const App({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(title,style: const TextStyle(
            color: Colors.white,
          ),),
          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
      ),
    );
  }
}

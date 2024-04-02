import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamprovider/user.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<String>(
          initialData: "Loading....",
          create: (context) => getUserName().asStream(),
        ),
        FutureProvider<int>(
          initialData: 0,
          create: (context) => getFlutterExperience(),
        ),
        ProxyProvider2<int, String, User>(
          update: (context, flutterExp, name, _) {
            return User(name: name, flutterExperience: flutterExp);
          },
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
        },
      ),
    );
  }

  Future<String> getUserName() async {
    await Future.delayed(const Duration(seconds: 3));
    return "Sourabh";
  }

  Future<int> getFlutterExperience() async {
    await Future.delayed(const Duration(seconds: 3));
    return 5;
  }
}

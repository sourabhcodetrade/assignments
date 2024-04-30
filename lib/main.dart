import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyACJx5_Lpd8yt1_HbzbqNTqgu8uRq5_8wo',
        appId: '1:442948320521:android:f2a6f806b4e69d846ce7d8',
        messagingSenderId: '442948320521',
        projectId: 'sign-in-methods-f2458',
        storageBucket: 'sign-in-methods-f2458.appspot.com',
      )
  );
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
      home:  const LoginScreen(),
    );
  }
}



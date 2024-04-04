import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpreference/home.dart';
import 'package:sharedpreference/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String? user = '';

  Future<void> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storedUser = prefs.getString('user');
    setState(() {
      user = storedUser ?? ''; // Assign a default value if storedUser is null
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user != '' ? const HomeScreen() : RegisterScreen(),
    );
  }
}

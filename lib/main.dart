
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureProvider<String>(
      initialData: "Loading....",
      create: (context) => getusername(),
      child:  MaterialApp(
        initialRoute: '/',
        routes: {
          '/' : (context)  => HomePage(),

        },
      ),
    );
  }

  Future<String> getusername() async{
    await Future.delayed(const Duration(seconds: 3));
    return "Sourabh";
  }

}

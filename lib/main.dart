
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_server.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  CustomServer customServer = CustomServer();
  final ip = await customServer.createServer(3000);
  runApp(MyApp(ip: ip));
}


class MyApp extends StatelessWidget {
  final String ip;
  const MyApp({super.key, required this.ip});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
        ),
        body: Center(
          child: Text("Ip Address = $ip",style: const TextStyle(
            fontSize: 32,
          ),),
        ),
      ),
    );
  }
}




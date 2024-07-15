import 'package:flutter/material.dart';

import 'master_card_channel.dart';

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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            MasterCardChannel().startPayment(
                merchantId: "tjID591DxiQJWWGXGt1JyGZyJWjZqhHtcaRYnMAic1e2f0a1",
                merchantName: "test",
                merchantUrl: "test");
          },
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.blueAccent)),
          child: const Text(
            'Pay Now',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

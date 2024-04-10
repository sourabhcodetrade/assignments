import 'package:flutter/material.dart';


class ResultScreen extends StatelessWidget {
  final String payload;
  const ResultScreen({super.key, required this.payload});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(payload),
      ),
    );
  }
}

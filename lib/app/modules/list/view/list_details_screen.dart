import 'package:flutter/material.dart';

class ListDetailsScreen extends StatelessWidget {
  const ListDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, int>;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Current Index : ${routeArgs['index'].toString()}"),
      ),
    );
  }
}

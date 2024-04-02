import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamprovider/user.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Consumer<User>(
          builder: (context, user, child) {
            return Text(
              user.toString(),
              style: const TextStyle(fontSize: 20),
            );
          },
        ),
      ),
    );
  }
}

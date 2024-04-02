import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Consumer<String>(
          builder: (context, username, child) {
            return Text(
              'Welcome, $username!',
              style: TextStyle(fontSize: 30),
            );
          },
        ),
      ),
    );
  }
}

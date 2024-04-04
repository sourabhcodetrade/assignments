import 'package:flutter/material.dart';
import 'package:mvc/app/routes.dart';
import 'package:provider/provider.dart';
import '../../auth/controller/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'user email',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black87),
              ),
              onPressed: () async {
                await authController.signOut();
                Navigator.pushReplacementNamed(context,Routes.loginScreen);

              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_sign_in/controllers/auth_controller.dart';
import 'package:firebase_sign_in/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        actions: [
          IconButton(onPressed: () async{

            await AuthController().signOut();
            if(context.mounted) Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen(),), (route) => false);

          }, icon: const Icon(Icons.logout)),
        ],
      ),
    );
  }
}

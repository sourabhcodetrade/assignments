import 'package:flutter/material.dart';

import '../utils/routes.dart';

class WelcomeScreen extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Chat Application',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Welcome to our App!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
               TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blueAccent),
                  foregroundColor: MaterialStatePropertyAll(Colors.white),
                ),
                onPressed: () {
                  if(controller.text.trim().isNotEmpty){
                    Navigator.pushReplacementNamed(
                        context,
                        Routes.chatScreen,
                        arguments: {
                          'username' : controller.text
                        }
                    );
                  }

                },
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_sign_in/controllers/auth_controller.dart';
import 'package:firebase_sign_in/views/home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SignInButton(
              elevation: 8,
              Buttons.googleDark,
              text: "Sign up with Google",
              onPressed: () async {
                final userCredential =
                    await AuthController().signInWithGoogle(context: context);

                if (userCredential?.user != null) {
                  if (context.mounted) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ));
                  }
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Login Failed'),
                        duration: const Duration(seconds: 3),
                        action: SnackBarAction(
                          label: 'Dismiss',
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                        ),
                      ),
                    );
                  }
                }
              },
            ),
            SignInButton(
                elevation: 8,
                Buttons.facebookNew,
                text: "Sign up with Facebook", onPressed: () async {
                  final userCredential = await AuthController().signInWithFacebook(context: context);
              if (userCredential?.user != null) {
                if (context.mounted) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
                }
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Login Failed'),
                      duration: const Duration(seconds: 3),
                      action: SnackBarAction(
                        label: 'Dismiss',
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    ),
                  );
                }
              }
            },
            ),
          ],
        ),
      ),
    );
  }
}

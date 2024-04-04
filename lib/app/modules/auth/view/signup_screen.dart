import 'package:flutter/material.dart';
import 'package:mvc/app/modules/auth/view/widgets/form.dart';
import 'package:provider/provider.dart';

import '../../../routes.dart';
import '../controller/auth_controller.dart';
import '../controller/password_validator.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            MyForm(
                formKey: formKey,
                emailController: emailController,
                passwordController: passwordController),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black87),
              ),
              onPressed: () async {
                if (formKey.currentState!.validate() &&
                    validatePassword(passwordController.text, context)) {
                  final user =
                      await authController.createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                          context: context);
                  if (user != null) {
                    Navigator.pushReplacementNamed(context, Routes.homeScreen);
                  } else {}
                }
              },
              child: const Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
                onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                child: const Text("Already have an account?, Log In")),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}

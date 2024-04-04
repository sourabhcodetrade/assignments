import 'package:flutter/material.dart';
import 'package:mvc/app/modules/auth/controller/auth_controller.dart';
import 'package:mvc/app/modules/auth/view/widgets/form.dart';
import 'package:provider/provider.dart';

import '../../../routes.dart';
import '../controller/password_validator.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final authController = Provider.of<AuthController>(context);
    return Scaffold(
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
              "Log In",
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
                if (formKey.currentState!.validate() && validatePassword(passwordController.text,context)) {
                  final user = await authController.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    context: context
                  );
                  if (user != null) {
                    Navigator.pushReplacementNamed(context, Routes.homeScreen);
                  } else {

                  }
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
                onTap: () => Navigator.pushReplacementNamed(
                    context, Routes.signupScreen),
                child: const Text("Already have an account?, Sig Up")),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}

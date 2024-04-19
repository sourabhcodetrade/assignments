import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supabase_example/modules/auth/controller/auth_controller.dart';
import 'package:supabase_example/modules/auth/view/widgets/form.dart';
import 'package:supabase_example/utils/routes.dart';

import '../controller/password_validator.dart';
import 'widgets/custom_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  void initState() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.cubeGrid
      ..maskType = EasyLoadingMaskType.black
      ..userInteractions = false
      ..dismissOnTap = false;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }



  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
            CustomButton(
              formKey: formKey,
              passwordController: passwordController,
              emailController: emailController,
              text: 'Create Account',
              onPressed: () async {
                if (formKey.currentState!.validate() &&
                    validatePassword(passwordController.text, context)) {
                  try {
                    EasyLoading.show(status: 'Loading...');
                    final authResponse =
                        await AuthController().signUpWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );

                    if (authResponse.user != null) {
                      EasyLoading.showSuccess("Success");
                      AuthController.registerUser(authResponse.user!.id);
                      if (context.mounted) {
                        EasyLoading.dismiss();
                        Navigator.pushReplacementNamed(
                            context, Routes.homeScreen);
                      }
                    }
                  } catch (e) {
                    EasyLoading.showError("$e");

                  }
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.loginScreen),
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

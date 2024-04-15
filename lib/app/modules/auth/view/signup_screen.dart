import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mvc/app/modules/auth/view/widgets/custom_button.dart';
import 'package:mvc/app/modules/auth/view/widgets/form.dart';
import 'package:provider/provider.dart';

import '../../../utils/routes/routes.dart';
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
  void initState() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..maskType = EasyLoadingMaskType.black
      ..userInteractions = false
      ..dismissOnTap = false;
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    formKey.currentState!.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
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
              authController: authController,
              emailController: emailController,
              text: 'Create Account',
              onPressed: () async {
                if (formKey.currentState!.validate() &&
                    validatePassword(passwordController.text, context)) {
                  EasyLoading.show(status: 'Creating Account');
                  final user =
                      await authController.createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                          context: context);
                  if (user != null) {
                    if (context.mounted) {
                      EasyLoading.dismiss();
                      Navigator.pushReplacementNamed(
                          context, Routes.homeScreen);
                    }
                  }
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
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

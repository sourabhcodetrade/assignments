import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mvc/app/modules/auth/controller/auth_controller.dart';
import 'package:mvc/app/modules/auth/view/widgets/custom_button.dart';
import 'package:mvc/app/modules/auth/view/widgets/form.dart';
import 'package:provider/provider.dart';
import '../../../utils/routes/routes.dart';
import '../controller/password_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    emailController.dispose();
    passwordController.dispose();
    formKey.currentState!.dispose();
    super.dispose();
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
              "Log In",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            MyForm(
              formKey: formKey,
              emailController: emailController,
              passwordController: passwordController,
            ),
            CustomButton(
              formKey: formKey,
              passwordController: passwordController,
              authController: authController,
              emailController: emailController,
              text: 'Login',
              onPressed: () async {
                if (formKey.currentState!.validate() &&
                    validatePassword(passwordController.text, context)) {
                  EasyLoading.show(status: 'Signing in');
                  final user = await authController.signInWithEmailAndPassword(
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
                onTap: () => Navigator.pushReplacementNamed(
                    context, Routes.signupScreen),
                child: const Text("Don't have an account?, Sig Up")),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}

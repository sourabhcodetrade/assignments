import 'package:firebase_auth_project/app/core/services/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/contants/color_constants.dart';
import '../../../../core/contants/routes.dart';
import '../../../../core/view/buttons/custom_button.dart';
import '../../../../core/view/custom/custom_app_bar_widget.dart';
import '../../../../core/view/input/outlined_text_form_field_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormFieldState> signupFormKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar("Signup"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const Gap(50),
            const Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 40,
                color: ColorConstants.primaryColor,
              ),
            ),
            const Gap(50),
            Form(
              key: signupFormKey,
              child: Column(
                children: [
                  OutLineTextFormField(
                    controller: emailController,
                    prefixIcon: const Icon(Icons.email),
                    labelText: "E-Mail",
                  ),
                  const Gap(10),
                  OutLineTextFormField(
                    controller: passwordController,
                    prefixIcon: const Icon(Icons.lock_outline),
                    obscureText: true,
                    showSuffixIcon: true,
                    labelText: "Password",
                    suffixIconButton: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.visibility)),
                  ),
                ],
              ),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => context.pushReplacementNamed(Routes.loginScreen),
                  child: const Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: ColorConstants.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => context.pushNamed(Routes.forgotPasswordScreen),
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: ColorConstants.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(30),
            CustomButton(
                onPressed: () {},
                width: double.infinity,
                height: 50,
                child: const Text("Create Account")),
          ],
        ),
      ),
    );
  }
}

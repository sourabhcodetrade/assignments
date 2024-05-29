import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/contants/color_constants.dart';
import '../../../../core/view/buttons/custom_button.dart';
import '../../../../core/view/custom/custom_app_bar_widget.dart';
import '../../../../core/view/input/outlined_text_form_field_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormFieldState> forgotPasswordFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar("Forgot Password?"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const Gap(50),
            const Text(
              "Enter E-mail to verify",
              style: TextStyle(
                fontSize: 20,
                color: ColorConstants.primaryColor,
              ),
            ),
            const Gap(50),
            Form(
              key: forgotPasswordFormKey,
              child: OutLineTextFormField(
                controller: emailController,
                prefixIcon: const Icon(Icons.email),
                labelText: "E-Mail",
              ),
            ),
            const Gap(30),
            CustomButton(
                onPressed: () {},
                width: double.infinity,
                height: 50,
                child: const Text("Submit")),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:supabase_example/modules/auth/view/widgets/text_input.dart';

class MyForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const MyForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
            child: TextInputField(
                controller: emailController,
                myIcon: Icons.email,
                myHintText: "Email",
                validator: "Please enter your Email"),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
            child: TextInputField(
                isHidden: true,
                controller: passwordController,
                myIcon: Icons.lock,
                myHintText: "Password",
                validator: "Please enter your Password"),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
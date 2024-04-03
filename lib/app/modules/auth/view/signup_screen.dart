import 'package:flutter/material.dart';
import 'package:mvc/app/modules/auth/view/widgets/form.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyForm(
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController),
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

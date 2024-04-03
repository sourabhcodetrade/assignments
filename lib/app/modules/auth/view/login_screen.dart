import 'package:flutter/material.dart';
import 'package:mvc/app/modules/auth/view/widgets/form.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onTap: () => Navigator.pushReplacementNamed(context, '/signup'),
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

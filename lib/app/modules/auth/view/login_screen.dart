import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supabase_chat_application/app/modules/auth/controller/login_controller.dart';
import 'package:supabase_chat_application/app/utils/constants/constants.dart';


import '../../../utils/routes/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    EasyLoading.instance
      ..maskType = EasyLoadingMaskType.black
      ..toastPosition = EasyLoadingToastPosition.center
      ..maskColor = Colors.amber
      ..indicatorType = EasyLoadingIndicatorType.pulse;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: ListView(
        padding: Constants.formPadding,
        children: [
          TextFormField(
            controller: LoginController.emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
          ),
          Constants.formSpacer,
          TextFormField(
            controller: LoginController.passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          Constants.formSpacer,
          LoginController().isLoading
              ? Constants.preloader
              : ElevatedButton(
                  onPressed: LoginController().isLoading
                      ? null
                      : () async {
                          await LoginController().signIn(context);
                        },
                  child: const Text('Login'),
                ),
          Constants.formSpacer,
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(Routes.signupScreen);
            },
            child: const Text('Don\'t have an account?'),
          )
        ],
      ),
    );
  }
}

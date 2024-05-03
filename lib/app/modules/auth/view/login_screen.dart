import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supabase_chat_application/app/modules/auth/controller/login_controller.dart';
import 'package:supabase_chat_application/app/utils/constants/constants.dart';
import 'package:get/get.dart';

import '../../../utils/routes/routes.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _loginController = Get.put(LoginController());

  @override
  void initState() {
    EasyLoading.instance
      ..maskType = EasyLoadingMaskType.black
      ..toastPosition = EasyLoadingToastPosition.center
      ..maskColor = Colors.amber
      ..indicatorType = EasyLoadingIndicatorType.pulse;
    super.initState();
  }

  // @override
  // void dispose() {
  //  _loginController.dispose();
  //  print("_loginController disposed");
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: ListView(
        padding: Constants.formPadding,
        children: [
          Obx(
            () {
              return TextFormField(
                controller: LoginController.emailController.value,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              );
            },
          ),
          Constants.formSpacer,
          Obx(
            () {
              return TextFormField(
                controller: LoginController.passwordController.value,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              );
            },
          ),
          Constants.formSpacer,
          Obx(
            () {
              return _loginController.isLoading.value
                  ? Constants.preloader
                  : ElevatedButton(
                      onPressed: _loginController.isLoading.value
                          ? null
                          : () async {
                              await LoginController().signIn(context);
                            },
                      child: const Text('Login'),
                    );
            },
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

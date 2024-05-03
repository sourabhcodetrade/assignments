import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:supabase_chat_application/app/modules/auth/controller/signup_controller.dart';
import 'package:supabase_chat_application/app/utils/constants/constants.dart';

import '../../../utils/routes/routes.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController _signUpController = Get.put(SignUpController());

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
  //  _signUpController.dispose();
  //  print('_signUpController disposed');
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Form(
        key: SignUpController.formKey.value,
        child: ListView(
          padding: Constants.formPadding,
          children: [
            Obx(
              () => TextFormField(
                controller: SignUpController.emailController.value,
                decoration: const InputDecoration(
                  label: Text('Email'),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Constants.formSpacer,
            Obx(
              () => TextFormField(
                controller: SignUpController.passwordController.value,
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text('Password'),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Required';
                  }
                  if (val.length < 6) {
                    return '6 characters minimum';
                  }
                  return null;
                },
              ),
            ),
            Constants.formSpacer,
            Obx(
              () => TextFormField(
                controller: SignUpController.usernameController.value,
                decoration: const InputDecoration(
                  label: Text('Username'),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Required';
                  }
                  final isValid = RegExp(r'^[A-Za-z0-9_]{3,24}$').hasMatch(val);
                  if (!isValid) {
                    return '3-24 long with alphanumeric or underscore';
                  }
                  return null;
                },
              ),
            ),
            Constants.formSpacer,
            Obx(
              () {
                return ElevatedButton(
                  onPressed: _signUpController.isLoading.value
                      ? null
                      : () async {
                          await SignUpController().signUp(context);
                        },
                  child: const Text('Register'),
                );
              },
            ),
            Constants.formSpacer,
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
              },
              child: const Text('I already have an account'),
            )
          ],
        ),
      ),
    );
  }
}

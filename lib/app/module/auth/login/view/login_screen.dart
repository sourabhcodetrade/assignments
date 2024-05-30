import 'package:firebase_auth_project/app/core/contants/color_constants.dart';
import 'package:firebase_auth_project/app/core/services/navigation_extension.dart';
import 'package:firebase_auth_project/app/core/view/buttons/custom_button.dart';
import 'package:firebase_auth_project/app/core/view/custom/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/contants/routes.dart';
import '../../../../core/services/toast_utils.dart';
import '../../../../core/view/custom/custom_loader_widget.dart';
import '../../../../core/view/input/outlined_text_form_field_widget.dart';
import '../loginBloc/login_screen_bloc.dart';
import '../loginBloc/login_screen_event.dart';
import '../loginBloc/login_screen_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final GlobalKey<FormFieldState> loginFormKey;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late bool isPasswordVisible;

  @override
  void initState() {
    initialiseControllers();
    super.initState();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  void initialiseControllers() {
    isPasswordVisible = false;
    loginFormKey = GlobalKey();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void _dispose() {
    loginFormKey.currentState?.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Scaffold build(BuildContext context) => Scaffold(
        appBar: const CustomAppBar("Login"),
        body: BlocListener<LoginScreenBloc, LoginScreenState>(
          listener: _loginBlocListener,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const Gap(50),
                const Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 40,
                    color: ColorConstants.primaryColor,
                  ),
                ),
                const Gap(50),
                Form(
                  key: loginFormKey,
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
                        obscureText: !isPasswordVisible,
                        showSuffixIcon: true,
                        labelText: "Password",
                        textInputType: TextInputType.visiblePassword,
                        suffixIconButton: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon: isPasswordVisible
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pushReplacementNamed(Routes.signupScreen);
                      },
                      child: const Text(
                        "Create an account",
                        style: TextStyle(
                          color: ColorConstants.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(Routes.forgotPasswordScreen);
                      },
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
                BlocBuilder<LoginScreenBloc, LoginScreenState>(
                  builder: (context, state) {
                    if (state is LoginScreenLoading) {
                      return const RoundedRectangleBorderLoadingWidget(
                        height: 100,
                        width: 100,
                      );
                    } else {
                      return CustomButton(
                          onPressed: () {
                            String email = emailController.text;
                            String password = passwordController.text;
                            context
                                .read<LoginScreenBloc>()
                                .add(Login(email, password));
                          },
                          width: double.infinity,
                          height: 50,
                          child: const Text("Log In"));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );

  void _loginBlocListener(_, LoginScreenState state) {
    if (state is LoginScreenSuccess) {
      print("State received");
      ToastUtils.success(state.msg);
    }
    if (state is LoginScreenFailure) {
      ToastUtils.failure(state.msg);
    }
  }
}

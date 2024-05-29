import 'package:firebase_auth_project/app/core/services/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/contants/color_constants.dart';
import '../../../../core/contants/routes.dart';
import '../../../../core/services/toast_utils.dart';
import '../../../../core/view/buttons/custom_button.dart';
import '../../../../core/view/custom/custom_app_bar_widget.dart';
import '../../../../core/view/custom/custom_loader_widget.dart';
import '../../../../core/view/input/outlined_text_form_field_widget.dart';
import '../singup_screen_bloc.dart';

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
  Scaffold build(BuildContext context) => Scaffold(
        appBar: const CustomAppBar("Signup"),
        body: BlocListener<SignUpScreenBloc, SignUpScreenState>(
          listener: _signUpBlocListener,
          child: Padding(
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
                            onPressed: () {},
                            icon: const Icon(Icons.visibility)),
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          context.pushReplacementNamed(Routes.loginScreen),
                      child: const Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: ColorConstants.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          context.pushNamed(Routes.forgotPasswordScreen),
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
                BlocBuilder<SignUpScreenBloc, SignUpScreenState>(
                  builder: (context, state) {
                    if (state is SingUpScreenLoading) {
                      return const SizedBox(
                        child: RoundedRectangleBorderLoadingWidget(
                          height: 100,
                          width: 100,
                        ),
                      );
                    } else {
                      return CustomButton(
                          onPressed: () {
                            String email = emailController.text;
                            String password = passwordController.text;
                            context
                                .read<SignUpScreenBloc>()
                                .add(SignUp(email, password));
                          },
                          width: double.infinity,
                          height: 50,
                          child: const Text("Create Account"));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );

  void _signUpBlocListener(_, SignUpScreenState state) {
    if (state is SignUpScreenSuccess) {
      ToastUtils.success(state.msg);
    }
    if (state is SingUpScreenFailure) {
      ToastUtils.failure(state.msg);
    }
  }
}

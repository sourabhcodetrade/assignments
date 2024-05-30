import 'package:firebase_auth_project/app/core/services/enum_input_type.dart';
import 'package:firebase_auth_project/app/core/services/navigation_extension.dart';
import 'package:firebase_auth_project/app/core/view/custom/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/contants/color_constants.dart';
import '../../../../core/contants/routes.dart';
import '../../../../core/services/toast_utils.dart';
import '../../../../core/view/buttons/custom_button.dart';
import '../../../../core/view/custom/custom_app_bar_widget.dart';
import '../../../../core/view/input/outlined_text_form_field_widget.dart';
import '../signup_bloc/singup_screen_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _signupFormKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  void _dispose() {
    _signupFormKey.currentState?.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Scaffold build(BuildContext context) => Scaffold(
        appBar: const CustomAppBar("Signup"),
        body: BlocListener<SignUpScreenBloc, SignUpScreenState>(
          listener: _signUpBlocListener,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/firebase.svg"),
                      const Gap(5),
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 40,
                          color: ColorConstants.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const Gap(50),
                  Form(
                    key: _signupFormKey,
                    child: Column(
                      children: [
                        OutLineTextFormField(
                          controller: _emailController,
                          prefixIcon: const Icon(Icons.email),
                          labelText: "E-Mail",
                          inputTypeEnum: InputTypeEnum.email,
                        ),
                        const Gap(10),
                        OutLineTextFormField(
                          controller: _passwordController,
                          prefixIcon: const Icon(Icons.lock_outline),
                          obscureText: true,
                          showSuffixIcon: true,
                          labelText: "Password",
                          inputTypeEnum: InputTypeEnum.password,
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
                  CustomButton(
                    onPressed: () {
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      if (_signupFormKey.currentState!.validate()) {
                        context
                            .read<SignUpScreenBloc>()
                            .add(SignUp(email, password));
                      }
                    },
                    width: double.infinity,
                    height: 50,
                    child: const Text("Create Account"),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void _signUpBlocListener(BuildContext context, SignUpScreenState state) {
    if(state is SingUpScreenLoading){
      CustomDialog.showLoader(context);
    }
    if (state is SignUpScreenSuccess) {
      CustomDialog.hideDialog(context);
      ToastUtils.success(state.msg);
    }
    if (state is SingUpScreenFailure) {
      CustomDialog.hideDialog(context);
      ToastUtils.failure(state.msg);
    }
  }
}

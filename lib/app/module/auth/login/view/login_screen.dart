import 'package:firebase_auth_project/app/core/contants/color_constants.dart';
import 'package:firebase_auth_project/app/core/view/buttons/custom_button.dart';
import 'package:firebase_auth_project/app/core/view/custom/custom_app_bar_widget.dart';
import 'package:firebase_auth_project/app/core/view/custom/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../../core/contants/routes.dart';
import '../../../../core/services/enum_input_type.dart';
import '../../../../core/services/toast_utils.dart';
import '../../../../core/view/input/outlined_text_form_field_widget.dart';
import '../login_bloc/login_screen_bloc.dart';
import '../login_bloc/login_screen_event.dart';
import '../login_bloc/login_screen_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  void _dispose() {
    _loginFormKey.currentState?.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Scaffold build(BuildContext context) => Scaffold(
        appBar: const CustomAppBar(
          "Login",
         showLeading: false,
        ),
        body: BlocListener<LoginScreenBloc, LoginScreenState>(
          listener: _loginBlocListener,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                      "Log In",
                      style: TextStyle(
                        fontSize: 40,
                        color: ColorConstants.primaryColor,
                      ),
                    ),
                  ],
                ),
                const Gap(50),
                Form(
                  key: _loginFormKey,
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
                        obscureText: !_isPasswordVisible,
                        showSuffixIcon: true,
                        labelText: "Password",
                        textInputType: TextInputType.visiblePassword,
                        inputTypeEnum: InputTypeEnum.password,
                        suffixIconButton: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            icon: _isPasswordVisible
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
                      onTap: () => Navigator.of(context)
                          .pushReplacementNamed(Routes.signupScreen),
                      child: const Text(
                        "Create an account",
                        style: TextStyle(
                          color: ColorConstants.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushReplacementNamed(Routes.forgotPasswordScreen),
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
                    if (_loginFormKey.currentState!.validate()) {
                      context
                          .read<LoginScreenBloc>()
                          .add(Login(email, password));
                    }
                  },
                  width: double.infinity,
                  height: 50,
                  child: const Text("Log In"),
                ),
              ],
            ),
          ),
        ),
      );

  void _loginBlocListener(BuildContext context, LoginScreenState state) {
    if (state is LoginScreenLoading) {
      CustomDialog.showLoader(context);
    }
    if (state is LoginScreenSuccess) {
      CustomDialog.hideDialog(context);
      ToastUtils.success(state.msg);
      Navigator.of(context).pushReplacementNamed(Routes.homeScreen);

    }
    if (state is LoginScreenFailure) {
      CustomDialog.hideDialog(context);
      ToastUtils.failure(state.msg);
    }
  }
}

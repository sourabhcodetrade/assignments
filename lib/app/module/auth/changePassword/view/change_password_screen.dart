import 'package:firebase_auth_project/app/module/auth/changePassword/change_password_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/contants/color_constants.dart';
import '../../../../core/services/toast_utils.dart';
import '../../../../core/view/buttons/custom_button.dart';
import '../../../../core/view/custom/custom_app_bar_widget.dart';
import '../../../../core/view/input/outlined_text_form_field_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormFieldState> changePasswordKey = GlobalKey();
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController repeatNewPasswordController =
      TextEditingController();
  bool isPasswordVisible = false;
  @override
  Scaffold build(BuildContext context) => Scaffold(
        appBar: const CustomAppBar("Change Password"),
        body: BlocListener<ChangePasswordScreenBloc, ChangePasswordScreenState>(
          listener: _changePasswordBlocListener,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const Gap(50),
                const Text(
                  "Enter details to change password",
                  style: TextStyle(
                    fontSize: 20,
                    color: ColorConstants.primaryColor,
                  ),
                ),
                const Gap(50),
                Form(
                  key: changePasswordKey,
                  child: Column(
                    children: [
                      OutLineTextFormField(
                        controller: currentPasswordController,
                        prefixIcon: const Icon(Icons.lock_outline),
                        labelText: "Current Password",
                        obscureText: true,
                      ),
                      const Gap(10),
                      OutLineTextFormField(
                        controller: newPasswordController,
                        prefixIcon: const Icon(Icons.lock_outline),
                        obscureText: true,
                        labelText: "New Password",
                      ),
                      const Gap(10),
                      OutLineTextFormField(
                        controller: repeatNewPasswordController,
                        prefixIcon: const Icon(Icons.lock_outline),
                        obscureText: !isPasswordVisible,
                        showSuffixIcon: true,
                        suffixIconButton: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon: isPasswordVisible
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
                        labelText: "Repeat New password",
                      ),
                    ],
                  ),
                ),
                const Gap(30),
                CustomButton(
                    onPressed: () {
                      context
                          .read<ChangePasswordScreenBloc>()
                          .add(ChangePassword(currentPasswordController.text, newPasswordController.text));
                    },
                    width: double.infinity,
                    height: 50,
                    child: const Text("Submit")),
              ],
            ),
          ),
        ),
      );

  void _changePasswordBlocListener(_, ChangePasswordScreenState state) async {
    if (state is ChangePasswordScreenSuccess) {
      ToastUtils.success(state.msg);
    }
    if (state is ChangePasswordScreenFailure) {
      ToastUtils.failure(state.msg);
    }
  }
}

import 'package:firebase_auth_project/app/core/services/enum_input_type.dart';
import 'package:firebase_auth_project/app/core/services/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/contants/color_constants.dart';
import '../../../../core/services/toast_utils.dart';
import '../../../../core/view/buttons/custom_button.dart';
import '../../../../core/view/custom/custom_app_bar_widget.dart';
import '../../../../core/view/custom/custom_dialog_widget.dart';
import '../../../../core/view/input/outlined_text_form_field_widget.dart';
import '../change_password_bloc/change_password_screen_bloc.dart';
import '../change_password_bloc/change_password_screen_event.dart';
import '../change_password_bloc/change_password_screen_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _changePasswordKey = GlobalKey();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  void _dispose() {
    _changePasswordKey.currentState?.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Scaffold build(BuildContext context) => Scaffold(
        appBar: const CustomAppBar("Change Password"),
        body: BlocListener<ChangePasswordScreenBloc, ChangePasswordScreenState>(
          listener: _changePasswordBlocListener,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SingleChildScrollView(
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
                    key: _changePasswordKey,
                    child: Column(
                      children: [
                        OutLineTextFormField(
                          controller: _currentPasswordController,
                          prefixIcon: const Icon(Icons.lock_outline),
                          labelText: "Current Password",
                          obscureText: true,
                          inputTypeEnum: InputTypeEnum.password,
                        ),
                        const Gap(10),
                        OutLineTextFormField(
                          controller: _newPasswordController,
                          prefixIcon: const Icon(Icons.lock_outline),
                          obscureText: true,
                          labelText: "New Password",
                          inputTypeEnum: InputTypeEnum.password,
                        ),
                        const Gap(10),
                        OutLineTextFormField(
                          controller: _confirmPasswordController,
                          prefixIcon: const Icon(Icons.lock_outline),
                          obscureText: !_isPasswordVisible,
                          showSuffixIcon: true,
                          inputTypeEnum: InputTypeEnum.password,
                          validator: (value) {
                            RegExp regex = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
                            if (value!.isEmpty) {
                              return "Please enter confirm password";
                            } else {
                              if (_newPasswordController.text != value) {
                                return "Password not matched ${_newPasswordController.text} != $value}";
                              } else {
                                if (!regex.hasMatch(value)) {
                                  return "Enter valid password";
                                } else {
                                  return null;
                                }
                              }
                            }
                          },
                          suffixIconButton: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              icon: _isPasswordVisible
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                          labelText: "Confirm password",
                        ),
                      ],
                    ),
                  ),
                  const Gap(30),
                  CustomButton(
                      onPressed: () {
                        if (_changePasswordKey.currentState!.validate()) {
                          context.read<ChangePasswordScreenBloc>().add(
                              ChangePassword(
                                  _currentPasswordController.text,
                                  _newPasswordController.text,
                                  _confirmPasswordController.text));
                        }
                      },
                      width: double.infinity,
                      height: 50,
                      child: const Text("Submit")),
                ],
              ),
            ),
          ),
        ),
      );

  void _changePasswordBlocListener(_, ChangePasswordScreenState state) async {
    if (state is ChangePasswordScreenLoading) {
      CustomDialog.showLoader(context);
    }
    if (state is ChangePasswordScreenSuccess) {
      CustomDialog.hideDialog(context);
      ToastUtils.success(state.msg);
      if (mounted) context.pop();
    }
    if (state is ChangePasswordScreenFailure) {
      CustomDialog.hideDialog(context);
      ToastUtils.failure(state.msg);
    }
  }
}

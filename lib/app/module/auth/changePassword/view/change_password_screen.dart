import 'package:firebase_auth_project/app/core/services/enum_input_type.dart';
import 'package:firebase_auth_project/app/core/services/navigation_extension.dart';
import 'package:firebase_auth_project/app/module/auth/changePassword/changePasswordBloc/change_password_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/contants/color_constants.dart';
import '../../../../core/services/toast_utils.dart';
import '../../../../core/view/buttons/custom_button.dart';
import '../../../../core/view/custom/custom_app_bar_widget.dart';
import '../../../../core/view/custom/custom_loader_widget.dart';
import '../../../../core/view/input/outlined_text_form_field_widget.dart';
import '../changePasswordBloc/change_password_screen_event.dart';
import '../changePasswordBloc/change_password_screen_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> changePasswordKey = GlobalKey();
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isPasswordVisible = false;
  @override
  Scaffold build(BuildContext context) => Scaffold(
        appBar: const CustomAppBar("Change Password"),
        body: BlocListener<ChangePasswordScreenBloc, ChangePasswordScreenState>(
          listener: _changePasswordBlocListener,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SingleChildScrollView(
              child: BlocBuilder<ChangePasswordScreenBloc,
                  ChangePasswordScreenState>(
                builder: (context, state) {
                  if (state is ChangePasswordScreenInitial ||
                      state is ChangePasswordScreenFailure) {
                    return Column(
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
                                inputTypeEnum: InputTypeEnum.password,
                              ),
                              const Gap(10),
                              OutLineTextFormField(
                                controller: newPasswordController,
                                prefixIcon: const Icon(Icons.lock_outline),
                                obscureText: true,
                                labelText: "New Password",
                                inputTypeEnum: InputTypeEnum.password,
                              ),
                              const Gap(10),
                              OutLineTextFormField(
                                controller: confirmPasswordController,
                                prefixIcon: const Icon(Icons.lock_outline),
                                obscureText: !isPasswordVisible,
                                showSuffixIcon: true,
                                inputTypeEnum: InputTypeEnum.password,
                                validator: (value) {
                                  RegExp regex = RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
                                  if (value!.isEmpty) {
                                    return "Please enter confirm password";
                                  } else {
                                    if (newPasswordController.text != value) {
                                      return "Password not matched ${newPasswordController.text} != $value}";
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
                                        isPasswordVisible = !isPasswordVisible;
                                      });
                                    },
                                    icon: isPasswordVisible
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
                              if (changePasswordKey.currentState!.validate()) {
                                context.read<ChangePasswordScreenBloc>().add(
                                    ChangePassword(
                                        currentPasswordController.text,
                                        newPasswordController.text,
                                        confirmPasswordController.text));
                              } else {
                                print("Validation error");
                              }
                            },
                            width: double.infinity,
                            height: 50,
                            child: const Text("Submit")),
                      ],
                    );
                  }
                  if (state is ChangePasswordScreenSuccess) {
                    return const Center(
                      child: Text(
                        "Password Changed Successfully",
                        style: TextStyle(
                          fontSize: 20,
                          color: ColorConstants.primaryColor,
                        ),
                      ),
                    );
                  }
                  else {
                    return const Center(
                      child: RoundedRectangleBorderLoadingWidget(
                        height: 100,
                        width: 100,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      );

  void _changePasswordBlocListener(_, ChangePasswordScreenState state) async {
    if (state is ChangePasswordScreenSuccess) {
      ToastUtils.success(state.msg);
      if (mounted) context.pop();
    }
    if (state is ChangePasswordScreenFailure) {
      ToastUtils.failure(state.msg);
    }
  }
}

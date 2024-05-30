import 'package:firebase_auth_project/app/core/services/navigation_extension.dart';
import 'package:firebase_auth_project/app/module/auth/forgotPassword/forgotPasswordBloc/forgot_password_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/contants/color_constants.dart';
import '../../../../core/contants/routes.dart';
import '../../../../core/services/enum_input_type.dart';
import '../../../../core/services/toast_utils.dart';
import '../../../../core/view/buttons/custom_button.dart';
import '../../../../core/view/custom/custom_app_bar_widget.dart';
import '../../../../core/view/custom/custom_loader_widget.dart';
import '../../../../core/view/input/outlined_text_form_field_widget.dart';
import '../forgotPasswordBloc/forgot_password_screen_event.dart';
import '../forgotPasswordBloc/forgot_password_screen_state.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> forgotPasswordFormKey = GlobalKey();

  @override
  Scaffold build(BuildContext context) => Scaffold(
        appBar: const CustomAppBar("Forgot Password?"),
        body: BlocListener<ForgotPasswordScreenBloc, ForgotPasswordScreenState>(
          listener: _forgotPasswordBlocListener,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(50),
                  BlocBuilder<ForgotPasswordScreenBloc,
                      ForgotPasswordScreenState>(
                    builder: (context, state) {
                      if (state is ForgotPasswordScreenVerifiedOtpSuccess) {
                        return const SizedBox();
                      }
                      if (state is ForgotPasswordScreenOtpSentSuccess ||
                          state is ForgotPasswordScreenVerifiedOtpFailure) {
                        return const Text(
                          "Enter Otp to verify",
                          style: TextStyle(
                            fontSize: 20,
                            color: ColorConstants.primaryColor,
                          ),
                        );
                      }
                      if (state is ForgotPasswordScreenLoading) {
                        return const Text(
                          "Verifying please wait",
                          style: TextStyle(
                            fontSize: 20,
                            color: ColorConstants.primaryColor,
                          ),
                        );
                      } else {
                        return const Text(
                          "Enter E-mail to verify",
                          style: TextStyle(
                            fontSize: 20,
                            color: ColorConstants.primaryColor,
                          ),
                        );
                      }
                    },
                  ),
                  const Gap(50),
                  BlocBuilder<ForgotPasswordScreenBloc,
                      ForgotPasswordScreenState>(
                    builder: (context, state) {
                      if (state is ForgotPasswordScreenOtpSentFailure ||
                          state is ForgotPasswordScreenInitial) {
                        return Form(
                          key: forgotPasswordFormKey,
                          child: OutLineTextFormField(
                            controller: emailController,
                            prefixIcon: const Icon(Icons.email),
                            labelText: "E-Mail",
                            textInputType: TextInputType.emailAddress,
                            inputTypeEnum: InputTypeEnum.email,
                          ),
                        );
                      }
                      if (state is ForgotPasswordScreenOtpSentSuccess ||
                          state is ForgotPasswordScreenVerifiedOtpFailure) {
                        return Form(
                          key: forgotPasswordFormKey,
                          child: OutLineTextFormField(
                            controller: otpController,
                            prefixIcon:
                                const Icon(Icons.share_arrival_time_outlined),
                            labelText: "OTP",
                            maxLength: 6,
                            textInputType: TextInputType.number,
                            inputTypeEnum: InputTypeEnum.otp,
                          ),
                        );
                      }
                      if (state is ForgotPasswordScreenVerifiedOtpSuccess) {
                        return const Center(
                          child: Text("Verification SuccessFull"),
                        );
                      } else {
                        return const SizedBox(
                          height: 100,
                          width: 100,
                        );
                      }
                    },
                  ),
                  const Gap(30),
                  BlocBuilder<ForgotPasswordScreenBloc,
                      ForgotPasswordScreenState>(
                    builder: (context, state) {
                      if (state is ForgotPasswordScreenLoading) {
                        return const Center(
                          child: RoundedRectangleBorderLoadingWidget(
                            height: 100,
                            width: 100,
                          ),
                        );
                      }
                      if (state is ForgotPasswordScreenInitial ||
                          state is ForgotPasswordScreenOtpSentFailure) {
                        return CustomButton(
                            onPressed: () {
                              if (forgotPasswordFormKey.currentState!
                                  .validate()) {
                                context
                                    .read<ForgotPasswordScreenBloc>()
                                    .add(SendOtp(emailController.text));
                              } else {
                                print("Validation error");
                              }
                            },
                            width: double.infinity,
                            height: 50,
                            child: const Text("Send Otp"));
                      }

                      if (state is ForgotPasswordScreenOtpSentSuccess ||
                          state is ForgotPasswordScreenVerifiedOtpFailure) {
                        return CustomButton(
                            onPressed: () {
                              if (forgotPasswordFormKey.currentState!
                                  .validate()) {
                                context
                                    .read<ForgotPasswordScreenBloc>()
                                    .add(VerifyOtp(otpController.text));
                              } else {
                                print("Validation error");
                              }
                            },
                            width: double.infinity,
                            height: 50,
                            child: const Text("Verify Otp"));
                      }
                      if (state is ForgotPasswordScreenVerifiedOtpSuccess) {
                        return const SizedBox(
                          height: 100,
                          width: 100,
                        );
                      } else {
                        return const Center(
                          child: RoundedRectangleBorderLoadingWidget(
                            height: 100,
                            width: 100,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void _forgotPasswordBlocListener(_, ForgotPasswordScreenState state) async {
    if (state is ForgotPasswordScreenOtpSentSuccess) {
      ToastUtils.success(state.msg);
    }
    if (state is ForgotPasswordScreenVerifiedOtpSuccess) {
      ToastUtils.success(state.msg);
      if (mounted) {
        context.pushReplacementNamed(Routes.changePassword);
      }
    }
    if (state is ForgotPasswordScreenOtpSentFailure) {
      ToastUtils.failure(state.msg);
    }
    if (state is ForgotPasswordScreenVerifiedOtpFailure) {
      ToastUtils.failure(state.msg);
    }
  }
}

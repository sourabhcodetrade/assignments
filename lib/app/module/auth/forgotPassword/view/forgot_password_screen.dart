import 'package:firebase_auth_project/app/core/services/navigation_extension.dart';
import 'package:firebase_auth_project/app/module/auth/forgotPassword/forgot_password_screen_bloc.dart';
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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormFieldState> forgotPasswordFormKey = GlobalKey();

  @override
  Scaffold build(BuildContext context) => Scaffold(
        appBar: const CustomAppBar("Forgot Password?"),
        body: BlocListener<ForgotPasswordScreenBloc, ForgotPasswordScreenState>(
          listener: _forgotPasswordBlocListener,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const Gap(50),
                BlocBuilder<ForgotPasswordScreenBloc,
                    ForgotPasswordScreenState>(
                  builder: (context, state) {
                    if (state is! ForgotPasswordScreenVerifiedOtpSuccess) {
                      return const Text(
                        "Enter E-mail to verify",
                        style: TextStyle(
                          fontSize: 20,
                          color: ColorConstants.primaryColor,
                        ),
                      );
                    } else {
                      return const SizedBox();
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
                          maxLength: 4,
                          textInputType: TextInputType.number,
                        ),
                      );
                    }
                    if (state is ForgotPasswordScreenVerifiedOtpSuccess) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Verification SuccessFull"),
                            Text(
                                "Redirecting you to change password in 2 seconds"),
                          ],
                        ),
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
                            context
                                .read<ForgotPasswordScreenBloc>()
                                .add(SendOtp(emailController.text));
                          },
                          width: double.infinity,
                          height: 50,
                          child: const Text("Send Otp"));
                    }

                    if (state is ForgotPasswordScreenOtpSentSuccess ||
                        state is ForgotPasswordScreenVerifiedOtpFailure) {
                      return CustomButton(
                          onPressed: () {
                            context
                                .read<ForgotPasswordScreenBloc>()
                                .add(VerifyOtp(otpController.text));
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
      );

  void _forgotPasswordBlocListener(_, ForgotPasswordScreenState state) async {
    if (state is ForgotPasswordScreenOtpSentSuccess) {
      ToastUtils.success(state.msg);
    }
    if (state is ForgotPasswordScreenVerifiedOtpSuccess) {
      ToastUtils.success(state.msg);
      await Future.delayed(const Duration(seconds: 3));
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

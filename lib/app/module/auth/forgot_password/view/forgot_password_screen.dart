import 'package:firebase_auth_project/app/core/services/navigation_extension.dart';
import 'package:firebase_auth_project/app/core/view/custom/custom_dialog_widget.dart';
import 'package:firebase_auth_project/app/module/auth/forgot_password/forgot_password_bloc/send_otp_bloc/send_otp_bloc.dart';
import 'package:firebase_auth_project/app/module/auth/forgot_password/forgot_password_bloc/verify_otp_bloc/verify_otp_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/contants/color_constants.dart';
import '../../../../core/services/enum_input_type.dart';
import '../../../../core/services/toast_utils.dart';
import '../../../../core/view/buttons/custom_button.dart';
import '../../../../core/view/custom/custom_app_bar_widget.dart';
import '../../../../core/view/input/outlined_text_form_field_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _forgotPasswordFormKey = GlobalKey();

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  void _dispose() {
    _forgotPasswordFormKey.currentState?.dispose();
    _emailController.dispose();
    _otpController.dispose();
  }

  @override
  Scaffold build(BuildContext context) => Scaffold(
        appBar: const CustomAppBar("Forgot Password?"),
        body: MultiBlocListener(
          listeners: [
            BlocListener<SendOtpBloc, SendOtpState>(
              listener: _sendOtpBlocListener,
            ),
            BlocListener<VerifyOtpBloc, VerifyOtpState>(
              listener: _verifyOtpBlocListener,
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(50),
                  BlocBuilder<SendOtpBloc, SendOtpState>(
                    builder: (context, sendOtpBlocState) {
                      return BlocBuilder<VerifyOtpBloc, VerifyOtpState>(
                        builder: (context, verifyOtpBlocState) {
                          if (sendOtpBlocState is SendOtpFailure ||
                              sendOtpBlocState is SendOtpInitial ||
                              sendOtpBlocState is SendOtpLoading) {
                            return Column(
                              children: [
                                const Text(
                                  "Enter E-mail to verify",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: ColorConstants.primaryColor,
                                  ),
                                ),
                                const Gap(50),
                                Form(
                                  key: _forgotPasswordFormKey,
                                  child: OutLineTextFormField(
                                    controller: _emailController,
                                    prefixIcon: const Icon(Icons.email),
                                    labelText: "E-Mail",
                                    textInputType: TextInputType.emailAddress,
                                    inputTypeEnum: InputTypeEnum.email,
                                  ),
                                ),
                                const Gap(30),
                                CustomButton(
                                  onPressed: () {
                                    if (_forgotPasswordFormKey.currentState!
                                        .validate()) {
                                      context
                                          .read<SendOtpBloc>()
                                          .add(SendOtp(_emailController.text));
                                    }
                                  },
                                  width: double.infinity,
                                  height: 50,
                                  child: const Text("Send Otp"),
                                ),
                              ],
                            );
                          }
                          if (sendOtpBlocState is SendOtpSuccess ||
                              verifyOtpBlocState is VerifyOtpLoading ||
                              verifyOtpBlocState is VerifyOtpFailure ||
                              verifyOtpBlocState is VerifyOtpSuccess) {
                            return Column(
                              children: [
                                const Text(
                                  "Enter OTP to verify",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: ColorConstants.primaryColor,
                                  ),
                                ),
                                const Gap(50),
                                Form(
                                  key: _forgotPasswordFormKey,
                                  child: OutLineTextFormField(
                                    controller: _otpController,
                                    prefixIcon: const Icon(
                                        Icons.share_arrival_time_outlined),
                                    labelText: "OTP",
                                    maxLength: 6,
                                    textInputType: TextInputType.number,
                                    inputTypeEnum: InputTypeEnum.otp,
                                  ),
                                ),
                                const Gap(30),
                                CustomButton(
                                    onPressed: () {
                                      if (_forgotPasswordFormKey.currentState!
                                          .validate()) {
                                        context.read<VerifyOtpBloc>().add(
                                            VerifyOtp(_otpController.text));
                                      }
                                    },
                                    width: double.infinity,
                                    height: 50,
                                    child: const Text("Verify Otp"))
                              ],
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void _sendOtpBlocListener(BuildContext context, SendOtpState state) async {
    if (state is SendOtpLoading) {
      CustomDialog.showLoader(context);
    }
    if (state is SendOtpSuccess) {
      CustomDialog.hideDialog(context);
      ToastUtils.success(state.msg);
    }
    if (state is SendOtpFailure) {
      CustomDialog.hideDialog(context);
      ToastUtils.failure(state.msg);
    }
  }

  void _verifyOtpBlocListener(
      BuildContext context, VerifyOtpState state) async {
    if (state is VerifyOtpLoading) {
      CustomDialog.showLoader(context);
    }
    if (state is VerifyOtpSuccess) {
      CustomDialog.hideDialog(context);
      ToastUtils.success(state.msg);
      context.pop();
    }
    if (state is VerifyOtpFailure) {
      CustomDialog.hideDialog(context);
      ToastUtils.failure(state.msg);
    }
  }
}

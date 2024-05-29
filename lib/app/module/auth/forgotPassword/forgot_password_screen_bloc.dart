import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'forgot_password_screen_event.dart';
part 'forgot_password_screen_state.dart';

class ForgotPasswordScreenBloc
    extends Bloc<ForgotPasswordScreenEvent, ForgotPasswordScreenState> {
  ForgotPasswordScreenBloc() : super(ForgotPasswordScreenInitial()) {
    on<SendOtp>(_sendOtp);
    on<VerifyOtp>(_verifyOtp);
  }

  void _sendOtp(SendOtp event, Emitter<ForgotPasswordScreenState> emit) async {
    emit(const ForgotPasswordScreenLoading());
    print(event.email);
    await Future.delayed(const Duration(seconds: 3));
    if (event.email == 'abc') {
      emit(const ForgotPasswordScreenOtpSentSuccess("Otp Sent Success"));
    } else {
      emit(const ForgotPasswordScreenOtpSentFailure("Otp Sent Failed"));
    }
  }

  void _verifyOtp(
      VerifyOtp event, Emitter<ForgotPasswordScreenState> emit) async {
    emit(const ForgotPasswordScreenLoading());
    print(event.otp);
    await Future.delayed(const Duration(seconds: 3));
    if (event.otp == '1234') {
      emit(
          const ForgotPasswordScreenVerifiedOtpSuccess("Verified Otp Success"));
    } else {
      emit(const ForgotPasswordScreenVerifiedOtpFailure(
          "Otp Verification Failed"));
    }
  }
}

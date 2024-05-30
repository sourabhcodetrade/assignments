import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'verify_otp_event.dart';
part 'verify_otp_state.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  VerifyOtpBloc() : super(VerifyOtpInitial()) {
    on<VerifyOtp>(_verifyOtp);
  }

  void _verifyOtp(VerifyOtp event, Emitter<VerifyOtpState> emit) async {
    emit(VerifyOtpLoading());
    await Future.delayed(const Duration(seconds: 3));
    if (event.otp == '123456') {
      emit(const VerifyOtpSuccess("Verified Otp Success"));
    } else {
      emit(const VerifyOtpFailure("Otp Verification Failed"));
    }
  }
}

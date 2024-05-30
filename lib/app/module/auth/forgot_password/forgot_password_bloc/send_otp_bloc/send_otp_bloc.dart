import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'send_otp_event.dart';
part 'send_otp_state.dart';

class SendOtpBloc extends Bloc<SendOtpEvent, SendOtpState> {
  SendOtpBloc() : super(SendOtpInitial()) {
    on<SendOtp>(_sendOtp);
  }

  void _sendOtp(SendOtp event, Emitter<SendOtpState> emit) async {
    emit(SendOtpLoading());
    await Future.delayed(const Duration(seconds: 3));
    if (event.email == 'abc@gmail.com') {
      emit(const SendOtpSuccess("Otp Sent Success"));
    } else {
      emit(const SendOtpFailure("Otp Sent Failed"));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'forgot_password_screen_event.dart';
import 'forgot_password_screen_state.dart';


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
    if (event.email == 'abc@gmail.com') {
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
    if (event.otp == '123456') {
      emit(
          const ForgotPasswordScreenVerifiedOtpSuccess("Verified Otp Success"));
    } else {
      emit(const ForgotPasswordScreenVerifiedOtpFailure(
          "Otp Verification Failed"));
    }
  }
}

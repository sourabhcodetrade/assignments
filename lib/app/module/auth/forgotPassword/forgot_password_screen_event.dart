part of 'forgot_password_screen_bloc.dart';

@immutable
sealed class ForgotPasswordScreenEvent extends Equatable {
  const ForgotPasswordScreenEvent();
  @override
  List<Object> get props => [];
}

final class SendOtp extends ForgotPasswordScreenEvent {
  final String email;
  const SendOtp(this.email);
  @override
  List<Object> get props => [email];
}

final class VerifyOtp extends ForgotPasswordScreenEvent {
  final String otp;
  const VerifyOtp(this.otp);
  @override
  List<Object> get props => [otp];
}

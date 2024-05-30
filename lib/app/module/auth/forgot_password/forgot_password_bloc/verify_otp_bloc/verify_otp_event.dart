part of 'verify_otp_bloc.dart';

@immutable
sealed class VerifyOtpEvent extends Equatable {

  const VerifyOtpEvent();

  @override
  List<Object> get props => [];
}

final class VerifyOtp extends VerifyOtpEvent {
  final String otp;
  const VerifyOtp(this.otp);

}
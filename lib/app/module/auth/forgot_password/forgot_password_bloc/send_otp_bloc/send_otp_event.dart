part of 'send_otp_bloc.dart';

@immutable
sealed class SendOtpEvent extends Equatable {
  const SendOtpEvent();

  @override
  List<Object> get props => [];
}

final class SendOtp extends SendOtpEvent {
  final String email;
  const SendOtp(this.email);
}

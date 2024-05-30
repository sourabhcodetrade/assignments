part of 'send_otp_bloc.dart';

@immutable
sealed class SendOtpState extends Equatable {
  const SendOtpState();

  @override
  List<Object> get props => [];
}

final class SendOtpInitial extends SendOtpState {}

final class SendOtpLoading extends SendOtpState {}

final class SendOtpSuccess extends SendOtpState {
  final String msg;
  const SendOtpSuccess(this.msg);
}

final class SendOtpFailure extends SendOtpState {
  final String msg;
  const SendOtpFailure(this.msg);
}

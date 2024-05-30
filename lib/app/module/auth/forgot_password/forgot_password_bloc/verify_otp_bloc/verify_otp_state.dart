part of 'verify_otp_bloc.dart';

@immutable
sealed class VerifyOtpState extends Equatable {
  @override
  List<Object> get props => [];
  const VerifyOtpState();
}

final class VerifyOtpInitial extends VerifyOtpState {}

final class VerifyOtpLoading extends VerifyOtpState {}

final class VerifyOtpSuccess extends VerifyOtpState {
  final String msg;
  const VerifyOtpSuccess(this.msg);
}

final class VerifyOtpFailure extends VerifyOtpState {
  final String msg;
  const VerifyOtpFailure(this.msg);
}

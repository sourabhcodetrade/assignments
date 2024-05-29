part of 'forgot_password_screen_bloc.dart';

@immutable
sealed class ForgotPasswordScreenState extends Equatable {
  const ForgotPasswordScreenState();

  @override
  List<Object> get props => [];
}

final class ForgotPasswordScreenInitial extends ForgotPasswordScreenState {}

final class ForgotPasswordScreenLoading extends ForgotPasswordScreenState {
  const ForgotPasswordScreenLoading();
}

final class ForgotPasswordScreenOtpSentSuccess
    extends ForgotPasswordScreenState {
  final String msg;
  const ForgotPasswordScreenOtpSentSuccess(this.msg);
}

final class ForgotPasswordScreenOtpSentFailure
    extends ForgotPasswordScreenState {
  final String msg;

  const ForgotPasswordScreenOtpSentFailure(this.msg);
}

final class ForgotPasswordScreenVerifiedOtpSuccess
    extends ForgotPasswordScreenState {
  final String msg;

  const ForgotPasswordScreenVerifiedOtpSuccess(this.msg);
}

final class ForgotPasswordScreenVerifiedOtpFailure
    extends ForgotPasswordScreenState {
  final String msg;
  const ForgotPasswordScreenVerifiedOtpFailure(this.msg);
}

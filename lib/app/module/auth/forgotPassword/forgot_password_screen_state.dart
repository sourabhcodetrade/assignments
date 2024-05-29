part of 'forgot_password_screen_bloc.dart';

@immutable
sealed class ForgotPasswordScreenState extends Equatable {

  const ForgotPasswordScreenState();

  @override
  List<Object> get props => [];
}

final class ForgotPasswordScreenInitial extends ForgotPasswordScreenState {}

final class ForgotPasswordScreenLoading extends ForgotPasswordScreenState{

}

final class ForgotPasswordScreenOtpSentSuccess extends ForgotPasswordScreenState{

}
final class ForgotPasswordScreenOtpSentFailure extends ForgotPasswordScreenState{

}

final class ForgotPasswordScreenVerifiedOtpSuccess extends ForgotPasswordScreenState{

}
final class ForgotPasswordScreenVerifiedOtpFailure extends ForgotPasswordScreenState{

}


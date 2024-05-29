part of 'login_screen_bloc.dart';

@immutable
sealed class LoginScreenState extends Equatable {
  @override
  List<Object> get props => [];
  const LoginScreenState();
}

final class LoginScreenInitial extends LoginScreenState {}

final class LoginScreenLoading extends LoginScreenState {
  const LoginScreenLoading();
}

final class LoginScreenFailure extends LoginScreenState {
  final String msg;
  const LoginScreenFailure(this.msg);
}

final class LoginScreenSuccess extends LoginScreenState {
  final String msg;
  const LoginScreenSuccess(this.msg);
}

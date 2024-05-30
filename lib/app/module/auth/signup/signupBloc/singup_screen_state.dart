part of 'singup_screen_bloc.dart';

@immutable
sealed class SignUpScreenState extends Equatable {

  const SignUpScreenState();

  @override
  List<Object> get props => [];
}

final class SingUpScreenInitial extends SignUpScreenState {}


final class SingUpScreenLoading extends SignUpScreenState {

  const SingUpScreenLoading();
}

final class SingUpScreenFailure extends SignUpScreenState {
  final String msg;
  const SingUpScreenFailure(this.msg);
}

final class SignUpScreenSuccess extends SignUpScreenState {
  final String msg;
  const SignUpScreenSuccess(this.msg);
}
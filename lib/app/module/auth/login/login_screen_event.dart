part of 'login_screen_bloc.dart';

@immutable
sealed class LoginScreenEvent extends Equatable {
  @override
  List<Object> get props => [];

  const LoginScreenEvent();
}
final class Login extends LoginScreenEvent {
  final String email;
  final String password;

  const Login(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}




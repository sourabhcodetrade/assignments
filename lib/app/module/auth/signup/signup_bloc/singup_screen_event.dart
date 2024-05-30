part of 'singup_screen_bloc.dart';

@immutable
sealed class SingUpScreenEvent extends Equatable {

  @override
  List<Object> get props => [];

  const SingUpScreenEvent();
}


final class SignUp extends SingUpScreenEvent {
  final String email;
  final String password;
  const SignUp(this.email, this.password);

}


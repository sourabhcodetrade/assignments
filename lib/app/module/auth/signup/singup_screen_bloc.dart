import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'singup_screen_event.dart';
part 'singup_screen_state.dart';

class SignUpScreenBloc extends Bloc<SingUpScreenEvent, SignUpScreenState> {
  SignUpScreenBloc() : super(SingUpScreenInitial()) {
    on<SignUp>(_signUp);
  }

  void _signUp(SignUp event, Emitter<SignUpScreenState> emit) async {
    emit(const SingUpScreenLoading());
    print(event.email);
    print(event.password);
    await Future.delayed(const Duration(seconds: 3)).whenComplete(
      () => emit(
        const SignUpScreenSuccess("Account Created Successfully"),
      ),
    );
    // emit(const LoginScreenFailure("Login Failed"));
  }
}

import 'package:bloc/bloc.dart';

import 'login_screen_event.dart';
import 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  LoginScreenBloc() : super(LoginScreenInitial()) {
      on<Login>(_login);
  }

  void _login(Login event, Emitter<LoginScreenState> emit) async {
    emit(const LoginScreenLoading());
    print(event.email);
    print(event.password);
    await Future.delayed(const Duration(seconds: 3));
    emit(const LoginScreenSuccess("Login Successful"));
    // emit(const LoginScreenFailure("Login Failed"));
  }


}

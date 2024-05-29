import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  LoginScreenBloc() : super(LoginScreenInitial()) {
      on<Login>(login);
  }

  void login(Login event, Emitter<LoginScreenState> emit) async {
    print(event.email);
    print(event.password);
    emit(const LoginScreenFailure("Login Failed"));
    // emit(const LoginScreenSuccess("Login Successful"));
  }
}

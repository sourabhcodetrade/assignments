import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'singup_screen_event.dart';
part 'singup_screen_state.dart';

class SignUpScreenBloc extends Bloc<SingUpScreenEvent, SignUpScreenState> {
  SignUpScreenBloc() : super(SingUpScreenInitial()) {
    on<SignUp>(_signUp);
  }

  void _signUp(SignUp event, Emitter<SignUpScreenState> emit) async {
    emit(SingUpScreenLoading());
    await Future.delayed(const Duration(seconds: 3));
    emit(const SignUpScreenSuccess("Account Created Successfully"));
  }
}
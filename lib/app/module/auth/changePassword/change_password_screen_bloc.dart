import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'change_password_screen_event.dart';
part 'change_password_screen_state.dart';

class ChangePasswordScreenBloc extends Bloc<ChangePasswordScreenEvent, ChangePasswordScreenState> {
  ChangePasswordScreenBloc() : super(ChangePasswordScreenInitial()) {
    on<ChangePasswordScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

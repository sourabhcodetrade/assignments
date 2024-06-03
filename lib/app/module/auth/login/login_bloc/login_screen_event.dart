

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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

}



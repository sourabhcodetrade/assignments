import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
sealed class ChangePasswordScreenEvent extends Equatable {
  const ChangePasswordScreenEvent();

  @override
  List<Object> get props => [];
}

final class ChangePassword extends ChangePasswordScreenEvent {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePassword(
      this.currentPassword, this.newPassword, this.confirmPassword);

  @override
  List<Object> get props => [currentPassword, newPassword, confirmPassword];
}

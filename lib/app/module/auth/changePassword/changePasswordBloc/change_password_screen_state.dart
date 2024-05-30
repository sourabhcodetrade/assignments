
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
sealed class ChangePasswordScreenState extends Equatable {

  const ChangePasswordScreenState();

  @override
  List<Object> get props => [];
}

final class ChangePasswordScreenInitial extends ChangePasswordScreenState {}

final class ChangePasswordScreenLoading extends ChangePasswordScreenState {

  const ChangePasswordScreenLoading();
}

final class ChangePasswordScreenSuccess extends ChangePasswordScreenState {
  final String msg;

  const ChangePasswordScreenSuccess(this.msg);
}

final class ChangePasswordScreenFailure extends ChangePasswordScreenState {
  final String msg;
  const ChangePasswordScreenFailure(this.msg);
}

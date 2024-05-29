part of 'change_password_screen_bloc.dart';

@immutable
sealed class ChangePasswordScreenEvent extends Equatable {

  const ChangePasswordScreenEvent();

  @override
  List<Object> get props => [];
}

final class ChangePassword extends ChangePasswordScreenEvent {
  final String oldPassword;
  final String newPassword;

  const ChangePassword(this.oldPassword, this.newPassword);

  @override
  List<Object> get props => [oldPassword, newPassword];

}

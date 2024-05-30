import 'package:bloc/bloc.dart';

import 'change_password_screen_event.dart';
import 'change_password_screen_state.dart';

class ChangePasswordScreenBloc
    extends Bloc<ChangePasswordScreenEvent, ChangePasswordScreenState> {
  ChangePasswordScreenBloc() : super(ChangePasswordScreenInitial()) {
    on<ChangePassword>(_changePassword);
  }

  void _changePassword(
      ChangePassword event, Emitter<ChangePasswordScreenState> emit) async {
    emit(const ChangePasswordScreenLoading());
    await Future.delayed(const Duration(seconds: 3));
    if (event.newPassword != event.oldPassword) {
      emit(const ChangePasswordScreenSuccess("Password Changed Successfully"));
    } else {
      emit(const ChangePasswordScreenFailure("Password Changed Failed"));
    }
  }
}

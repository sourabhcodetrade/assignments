import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'forgot_password_screen_event.dart';
part 'forgot_password_screen_state.dart';

class ForgotPasswordScreenBloc extends Bloc<ForgotPasswordScreenEvent, ForgotPasswordScreenState> {
  ForgotPasswordScreenBloc() : super(ForgotPasswordScreenInitial()) {
    on<ForgotPasswordScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

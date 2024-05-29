import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'singup_screen_event.dart';
part 'singup_screen_state.dart';

class SingupScreenBloc extends Bloc<SingupScreenEvent, SingupScreenState> {
  SingupScreenBloc() : super(SingupScreenInitial()) {
    on<SingupScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState()) {
    on<IncrementCounter>(_increment);
    on<DecrementCounter>(_decrement);
  }

  void _increment(IncrementCounter event, Emitter<CounterState> emit) {
    if (kDebugMode) {
      print(state.counter);
    }
    emit(CounterState(counter: state.counter+1));
  }

  void _decrement(DecrementCounter event, Emitter<CounterState> emit) {
    if (kDebugMode) {
      print(state.counter);
    }
    emit(CounterState(counter: state.counter-1));

  }
}

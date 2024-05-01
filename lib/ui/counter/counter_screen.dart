import 'package:example_bloc/bloc/counter/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bloc Example',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<CounterBloc, CounterState>(builder: (context, state) {
              return Text(
                '${state.counter}',
                style: const TextStyle(fontSize: 60, color: Colors.black),
              );
            },),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<CounterBloc, CounterState>(
                  builder: (context, state) {
                    return Card(
                      elevation: 8,
                      color: Colors.blueAccent,
                      child: TextButton(
                        onPressed: () {
                          context.read<CounterBloc>().add(IncrementCounter());
                        },
                        child: const Text(
                          '+',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
                BlocBuilder<CounterBloc, CounterState>(
                  builder: (context, state) {
                    return Card(
                      elevation: 8,
                      color: Colors.blueAccent,
                      child: TextButton(
                        onPressed: () {
                          context.read<CounterBloc>().add(DecrementCounter());
                        },
                        child: const Text(
                          '-',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

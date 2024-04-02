import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerofexample/counter.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    // final counter = Provider.of<CounterProvider>(context,listen: true);
    // final counter = context.read<CounterProvider>();
    final counter = context.watch<CounterProvider>();
    final count = counter.count;
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              count.toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter.incrementCounter();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

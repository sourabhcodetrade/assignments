import 'package:flutter/material.dart';

final ValueNotifier<int> number = ValueNotifier(0);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                number.value += 1;
              },
              icon: const Icon(Icons.add),
            ),
            const SizedBox(
              height: 30,
            ),
            ValueListenableBuilder(
              valueListenable: number,
              builder: (context, value, child) => Text('$value',style: const TextStyle(
                fontSize: 30,
              ),),
            )
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<int> number = ValueNotifier(0);

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
              builder: (context, value, child) => Text(
                '$value',
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            IconButton(
              onPressed: () {
                number.value -= 1;
              },
              icon: const Icon(Icons.minimize),
            ),
          ],
        ),
      ),
    );
  }
}

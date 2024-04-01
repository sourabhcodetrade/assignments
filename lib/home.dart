import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'list_provider.dart';
import 'next.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NumberListProvider>(
      builder: (context, numberListProviderModel, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            numberListProviderModel.add();
          },
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            Text(
              numberListProviderModel.numbers.length.toString(),
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: numberListProviderModel.numbers.length,
                itemBuilder: (context, index) => Text(
                  numberListProviderModel.numbers[index].toString(),
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SecondScreen()),);
                },
                child: const Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

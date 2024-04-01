import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'list_provider.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
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
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            Text(
              numberListProviderModel.numbers.length.toString(),
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: numberListProviderModel.numbers.length,
                itemBuilder: (context, index) => Text(
                  numberListProviderModel.numbers[index].toString(),
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


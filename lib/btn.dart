import 'package:flutter/material.dart';

class Btn extends StatelessWidget {
  final VoidCallback callback;
  final String text;
  const Btn({
    super.key,
    required this.callback,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.teal),
      ),
      onPressed: callback,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'bank_account.dart';

late Box box;

Future<void> main() async {
  await Hive.initFlutter();
  box = await Hive.openBox('box');
  Hive.registerAdapter(BankAccountAdapter());
  box.put('bankAccount', BankAccount(currency: "\$USD", money: 1000));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BankAccount bankAccount = box.get('bankAccount');
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${bankAccount.currency} = ${bankAccount.money}"),
          ],
        ),
      ),
    );
  }
}

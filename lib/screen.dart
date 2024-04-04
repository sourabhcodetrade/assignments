// ignore_for_file: empty_statements

import 'package:flutter/material.dart';
import 'package:navigationsmethod/custom_button.dart';
import 'package:navigationsmethod/routes.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen 1')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
                text: "Push Named Screen 2 ",
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.screen2);
                }),
            CustomButton(
                text: "Push Screen 2 ",
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Screen2(),
                  ));
                }),
            CustomButton(
                text: "Pop Screen 1 ",
                onPressed: () {
                  Navigator.pop(context);
                }),
            CustomButton(
                text: "MaybePop Screen 1 ",
                onPressed: () {
                  Navigator.maybePop(context);
                }),
            CustomButton(
                text: "PopandPushNamed Screen 1 ",
                onPressed: () {
                  Navigator.popAndPushNamed(context, Routes.screen2);
                }),
            CustomButton(
                text: "MaybePop Screen 1 ",
                onPressed: () {
                  Navigator.maybePop(context);
                }),
            CustomButton(
                text: "CanPop  Screen 1 ",
                onPressed: () {
                  bool value = Navigator.canPop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(value.toString()),
                      duration: const Duration(seconds: 3),
                      action: SnackBarAction(
                        label: 'Dismiss',
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
                text: "Push Named Screen 3 ",
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.screen3);
                }),
            CustomButton(
                text: "Push Screen 3 ",
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Screen3(),
                  ));
                }),
            CustomButton(
                text: "Pop Screen 2 ",
                onPressed: () {
                  Navigator.pop(context);
                }),
            CustomButton(
                text: "MaybePop Screen 2 ",
                onPressed: () {
                  Navigator.maybePop(context);
                }),
            CustomButton(
                text: "PopandPushNamed Screen 3 ",
                onPressed: () {
                  Navigator.popAndPushNamed(context, Routes.screen3);
                }),
            CustomButton(
                text: "MaybePop Screen 2 ",
                onPressed: () {
                  Navigator.maybePop(context);
                }),
            CustomButton(
                text: "CanPop  Screen 2 ",
                onPressed: () {
                  bool value = Navigator.canPop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(value.toString()),
                      duration: const Duration(seconds: 3),
                      action: SnackBarAction(
                        label: 'Dismiss',
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen 3')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
                text: "Pop Screen 3 ",
                onPressed: () {
                  Navigator.pop(context);
                }),
            CustomButton(
                text: "MaybePop Screen 3 ",
                onPressed: () {
                  Navigator.maybePop(context);
                }),
            CustomButton(
                text: "MaybePop Screen 3 ",
                onPressed: () {
                  Navigator.maybePop(context);
                }),
            CustomButton(
                text: "Pop Screen 3 Until Screen 1 ",
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName(Routes.screen1));
                }),
            CustomButton(
                text: "CanPop  Screen 3 ",
                onPressed: () {
                  bool value = Navigator.canPop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(value.toString()),
                      duration: const Duration(seconds: 3),
                      action: SnackBarAction(
                        label: 'Dismiss',
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

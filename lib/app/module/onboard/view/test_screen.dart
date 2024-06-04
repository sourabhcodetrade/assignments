import 'dart:ui';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late List<Card> cards;

  final Color? oddItemColor = Colors.redAccent;
  final Color? evenItemColor = Colors.yellow;

  @override
  void initState() {
    super.initState();
    cards = <Card>[
      for (int index = 0; index < 50; index += 1)
        Card(
          key: UniqueKey(),
          color: index.isOdd ? oddItemColor : evenItemColor,
          child: SizedBox(
            height: 200,
            child: Center(
              child: Text('Card $index'),
            ),
          ),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reorder able List"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ReorderableListView(
              physics: const BouncingScrollPhysics(),
              proxyDecorator:
                  (Widget child, int index, Animation<double> animation) =>
                  proxyDecorator(child, index, animation),
              children: cards,
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final Card item = cards.removeAt(oldIndex);
                  cards.insert(newIndex, item);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double animValue = Curves.easeInOut.transform(animation.value);
        final double scale = lerpDouble(1, 1.02, animValue)!;
        final double elevation = lerpDouble(0, 6, animValue)!;
        return Transform.scale(
          scale: scale,
          child: Material(
            elevation: elevation,
            color: Colors.transparent,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

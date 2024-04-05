import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: GridViewScreen(),
      home: GridViewBuilderScreen(),
    );
  }
}

class GridViewScreen extends StatefulWidget {
  const GridViewScreen({super.key});

  @override
  State<GridViewScreen> createState() => _GridViewScreenState();
}

class _GridViewScreenState extends State<GridViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "GridView",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: [
          getItem(0),
          getItem(0),
          getItem(0),
          getItem(0),
          getItem(0),
          getItem(0),
          getItem(0),
          getItem(0),
          getItem(0),
          getItem(0),
          getItem(0),
          getItem(0),
          getItem(0),
          getItem(0),
          getItem(0),
          getItem(0),
        ],

      ),
    );
  }

  Widget getItem(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2, left: 2, right: 2),
      height: 300,
      width: 100,
      color: Colors.purple,
      child: Center(
        child: Text(
          "${index + 1}",
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class GridViewBuilderScreen extends StatefulWidget {
  const GridViewBuilderScreen({super.key});

  @override
  State<GridViewBuilderScreen> createState() => _GridViewBuilderScreenState();
}

class _GridViewBuilderScreenState extends State<GridViewBuilderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "GridView",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: 20,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return getItem(index);
          },
        ));
  }

  Widget getItem(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2, left: 2, right: 2),
      height: 300,
      width: 100,
      color: Colors.purple,
      child: Center(
        child: Text(
          "${index + 1}",
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // primaryColor: Colors.blueAccent,
        appBarTheme: const AppBarTheme(
          color: Colors.blueAccent,
          foregroundColor: Colors.white,
        ),
      ),
      // home: const ListViewScreen(),
      // home: const ListViewBuilderScreen(),
      home: const SilverListScreen(),
    );
  }
}

class ListViewScreen extends StatefulWidget {
  const ListViewScreen({super.key});

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ListView"),
        centerTitle: true,
      ),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        addAutomaticKeepAlives: false,
        children: [
          getItem(0),
          getItem(1),
          getItem(2),
          getItem(3),
          getItem(4),
          getItem(5),
          getItem(6),
          getItem(7),
          getItem(8),
          getItem(9),
        ],
      ),
    );
  }

  Widget getItem(int index) {
    print('$index constructed');
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

class ListViewBuilderScreen extends StatefulWidget {
  const ListViewBuilderScreen({super.key});

  @override
  State<ListViewBuilderScreen> createState() => _ListViewBuilderScreenState();
}

class _ListViewBuilderScreenState extends State<ListViewBuilderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ListViewBuilder"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 10,
        cacheExtent: 100,
        itemBuilder: (context, index) {
          return getItem(index);
        },
      ),
    );
  }

  Widget getItem(int index) {
    print('$index constructed');
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

class SilverListScreen extends StatelessWidget {
  const SilverListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 50,
              (context, index) {
                return ListTile(
                  title: Text("Item ${index + 1}"),
                  tileColor: Colors.orange[100 * (index % 9 + 1)],
                );
              },
            ),
          ), // Place sliver widgets here
        ],
      ),
    );
  }
}

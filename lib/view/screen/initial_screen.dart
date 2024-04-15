import 'package:analytics_example/view/screen/pages/home_page.dart';
import 'package:analytics_example/view/screen/pages/profile_page.dart';
import 'package:analytics_example/view/screen/pages/search_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  int selectedIndex = 0;
  static List pageNames = ['HomePage', 'SearchPage', 'ProfilePage'];
  static List<Widget> pages = <Widget>[
    HomePage(),
    SearchPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Analytics"),
        centerTitle: true,
      ),
      body: Center(
        child: pages.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: (value) async {
          await analytics.logEvent(
              name: 'pages_tracked',
              parameters: {'page_name': pageNames[value], 'page_index': value});

          setState(() {
            selectedIndex = value;
          });
        },
      ),
    );
  }
}

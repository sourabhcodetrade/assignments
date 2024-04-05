import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double w =  MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            height: 100,
            width: w*0.25,
            color: Colors.red,
          ),Container(
            height: 100,
            width: w*0.25,
            color: Colors.yellow,
          ),Container(
            height: 100,
            width: w*0.25,
            color: Colors.green,
          ),Container(
            height: 100,
            width: w*0.25,
            color: Colors.pink,
          ),
        ],

      ),
    );
  }
}

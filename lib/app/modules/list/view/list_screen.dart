import 'package:flutter/material.dart';

import '../../../utils/routes/routes.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: ListView(
          children: [
            getItem(0),
            getItem(1),
            getItem(3),
            getItem(4),
            getItem(5),
            getItem(6),
            getItem(7),
            getItem(8),
            getItem(9),
            getItem(10),
            getItem(11),
            getItem(12),
            getItem(13),
            getItem(14),
            getItem(15),
            getItem(16),
            getItem(17),
            getItem(18),
          ],
        ),
      ),
    );
  }

  Widget getItem(int index) {
    // ignore: avoid_print
    print('$index constructed');
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.listDetailsScreen,
          arguments: {'index': index},
        );
      },
      child: const Card(
        margin: EdgeInsets.only(top: 2, bottom: 2, left: 2, right: 2),
        color: Colors.purple,
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkT_ekN8QGrKWktlwVjxqPbfWZv6d4u0foEw&s"),
              ),
              Text(
                "Devin",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Getx'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            child: ListTile(
              title: Text('Open Bottom Sheet'),
              onTap: (){

                Get.bottomSheet(
                  backgroundColor: Colors.white,
                  Column(
                    children: [
                      Card(
                        child: ListTile(
                          onTap: (){
                            Get.changeTheme(ThemeData.dark());
                          },
                          leading: Icon(Icons.dark_mode),
                          title: Text('Dark Theme'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          onTap: (){
                            Get.changeTheme(ThemeData.light());
                          },
                          leading: Icon(Icons.light_mode),
                          title: Text('Light Theme'),
                        ),
                      ),
                    ],
                  ),

                );

              },

            ),
          ),
        ],
      ),
    );
  }
}

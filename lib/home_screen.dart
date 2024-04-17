import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_isoolate/api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List dataList = [];
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    // ReceivePort receiverPort = ReceivePort();
    // Isolate.spawn(getData, receiverPort.sendPort);
    // dataList = await receiverPort.first;
    dataList = await compute( getData, "message");
    setState(() {});
    print("Isolate Result = $dataList");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Super heroes",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            dataList.isEmpty
                ? const SizedBox()
                : Expanded(
                    child: ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (context, index) => Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                              dataList[index]['images']['lg'],
                            ),
                          ),
                          title: Text(dataList[index]['name'].toString()),
                          trailing: Text(
                              "Strength: ${dataList[index]['powerstats']['strength']}"),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

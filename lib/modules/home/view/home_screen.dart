import 'dart:convert';

// ignore: unused_import
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http_dio/modules/auth/view/auth_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List dataList = [];

  @override
  void initState() {
    super.initState();
    loaderInit();
    getData();

  }

  void loaderInit() {
    EasyLoading.instance
      ..maskType = EasyLoadingMaskType.black
      ..toastPosition = EasyLoadingToastPosition.top
      ..indicatorType = EasyLoadingIndicatorType.pulse;
  }

  void getData() async {
    try {
      EasyLoading.show(status: 'Loading...');
      const url = 'https://superhero-search.p.rapidapi.com/api/heroes';
      const headers = {
        'X-RapidAPI-Key': '4f45c1c748mshac8fd3b453b345bp11488ajsnc197908c7307',
        'X-RapidAPI-Host': 'superhero-search.p.rapidapi.com'
      };
      // Dio Method
      // Response response = await Dio().get(
      //   url,
      //   options: Options(
      //     headers: headers,
      //   ),
      // );

      //http method

      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      //
      if (response.statusCode == 200) {
        setState(() {
          dataList = jsonDecode(response.body);
          EasyLoading.dismiss();
          Fluttertoast.showToast(
              msg: "Data Loaded",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black87,
              textColor: Colors.white,
              fontSize: 16.0);

        });
      } else {
        debugPrint("Something went wrong");
        EasyLoading.dismiss();
      }
    } on DioException catch (e) {
      debugPrint('Error fetching data: $e');
      EasyLoading.dismiss();
    } catch (e) {
      debugPrint('Error fetching data: $e');
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthScreen(),
                  ));
            },
            icon: const Icon(Icons.lock,color: Colors.white,),
          ),
        ],
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                        elevation: 8,
                        child: ListTile(
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

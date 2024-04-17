import 'dart:convert';
import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

@pragma('vm:entry-point')
void getData(SendPort sendPort) async {
  List dataList = [];
  try {
    const url = 'https://superhero-search.p.rapidapi.com/api/heroes';
    const headers = {
      'X-RapidAPI-Key': '4f45c1c748mshac8fd3b453b345bp11488ajsnc197908c7307',
      'X-RapidAPI-Host': 'superhero-search.p.rapidapi.com'
    };

    Response response = await Dio().get(
      url,
      options: Options(
        headers: headers,
      ),
    );

    //
    if (response.statusCode == 200) {
      dataList = jsonDecode(response.data);
      sendPort.send(dataList);
    } else {
      debugPrint("Something went wrong");
      sendPort.send("Something went wrong");
    }
  } on DioException catch (e) {
    debugPrint('Error fetching data: $e');
    sendPort.send('Error fetching data: $e');
  } catch (e) {
    debugPrint('Error fetching data: $e');
    sendPort.send('Error fetching data: $e');
  }
}

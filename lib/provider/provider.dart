import 'package:flutter/material.dart';

import '../modules/dashboard/controller/database_controller.dart';
import '../modules/dashboard/model/data_model.dart';

class DataHandlerProvider with ChangeNotifier {
  late DataModel dataModel;
  bool isLoading = true;
  List<Map<String, dynamic>> messages = [];

  void callApi() async {
    dataModel = await DatabaseController().fetchData();
    print(dataModel.statusCode);
    if (dataModel.statusCode == 200) {
      messages = (dataModel.data.data?['messagesCollection']?['edges'] ?? [])
          .map<Map<String, dynamic>>(
              (edge) => edge['node'] as Map<String, dynamic>)
          .toList();
    }
    isLoading = false;
    notifyListeners();
  }
}

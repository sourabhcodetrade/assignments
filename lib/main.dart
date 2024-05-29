import 'package:firebase_auth_project/app/core/manager/get_it_manager.dart';
import 'package:flutter/material.dart';
import 'app/module/onboard/view/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeGetItDependencies();
  runApp(const MyApp());
}

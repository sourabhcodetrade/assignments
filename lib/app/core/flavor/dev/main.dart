import 'package:firebase_auth_project/app/core/manager/get_it_manager.dart';
import 'package:flutter/material.dart';

import '../../contants/routes.dart';
import '../../manager/navigation_manager.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeGetItDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Dev',
      onGenerateRoute: NavigationManager.onGenerateRoute,
      initialRoute: Routes.splashScreen,
    );
  }
}

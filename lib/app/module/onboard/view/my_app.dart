import 'package:flutter/material.dart';

import '../../../core/contants/routes.dart';
import '../../../core/manager/navigation_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: NavigationManager.onGenerateRoute,
      initialRoute: Routes.splashScreen,
    );
  }
}
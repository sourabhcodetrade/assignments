import 'package:flutter/material.dart';
import 'package:mvc/app/utils/routes/routes.dart';
import 'package:provider/provider.dart';

import '../../settings/controller/theme_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(context, Routes.wrapper,(route) => false);
    });
  }

  // getThemeMode(BuildContext context){
  //   final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
  //
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlutterLogo(
              size: 200,
            ),
          ],
        ),
      ),
    );
  }
}

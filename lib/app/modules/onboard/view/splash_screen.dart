import 'package:flutter/material.dart';
import 'package:mvc/app/utils/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    Future.delayed(Duration.zero, () {
      getThemeMode(context);
    });

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.wrapper, (route) => false);
    });
  }

  getThemeMode(BuildContext context) async {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool light = prefs.getBool('light') ?? true;

    light ? themeProvider.setLightMode() : themeProvider.setDarkMode();
  }

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

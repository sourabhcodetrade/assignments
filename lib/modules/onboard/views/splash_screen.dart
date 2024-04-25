import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/routes.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String? userID = '';

  Future<void> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storedUser = prefs.getString('userID');
    setState(() {
      userID = storedUser ?? '';
    });
    print("userID = $userID");
  }

  @override
  void initState() {
    getUser();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
          context, userID != '' ? Routes.homeScreen : Routes.loginScreen);
    });
    super.initState();
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
            SizedBox(
              height: 30,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

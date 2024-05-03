import 'package:flutter/material.dart';
import 'package:supabase_chat_application/app/modules/onboard/controller/splash_screen_controller.dart';
import 'package:supabase_chat_application/app/utils/constants/constants.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero);
    SplashController().redirect(context);

  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(
              size: 100,
            ),
            SizedBox(height: 20),
            Constants.preloader,
          ],
        ),
      ),
    );
  }
}



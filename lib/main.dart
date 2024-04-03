import 'package:flutter/material.dart';
import 'app/modules/auth/view/login_screen.dart';
import 'app/modules/auth/view/signup_screen.dart';
import 'app/modules/dashboard/view/home_screen.dart';
import 'app/modules/onboard/view/splash_screen.dart';
import 'app/routes.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashScreen,
      routes: {
        Routes.splashScreen: (context) => const SplashScreen(),
        Routes.signupScreen: (context) => const SignupScreen(),
        Routes.loginScreen: (context) => const LoginScreen(),
        Routes.homeScreen: (context) => const HomeScreen(),
      },
    );
  }
}

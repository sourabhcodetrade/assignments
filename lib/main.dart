import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mvc/app/modules/auth/controller/auth_controller.dart';
import 'package:mvc/app/wrapper.dart';
import 'package:provider/provider.dart';
import 'app/modules/auth/view/login_screen.dart';
import 'app/modules/auth/view/signup_screen.dart';
import 'app/modules/dashboard/view/home_screen.dart';
import 'app/modules/onboard/view/splash_screen.dart';
import 'app/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyAQjEgN2n22yyQVBFinR3AaRxrFeajNuTc',
    appId: 'com.example.mvc',
    messagingSenderId: 'sendid',
    projectId: 'mvcapp-540be',
    storageBucket: 'mvcapp-540be.appspot.com',
  )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthController>(
          create: (context) => AuthController(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.wrapper,
        routes: {
          Routes.wrapper: (context) => const Wrapper(),
          Routes.splashScreen: (context) => const SplashScreen(),
          Routes.signupScreen: (context) => const SignupScreen(),
          Routes.loginScreen: (context) => const LoginScreen(),
          Routes.homeScreen: (context) => HomeScreen(),
        },
      ),
    );
  }
}

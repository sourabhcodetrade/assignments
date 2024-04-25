import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:supabase_example/modules/onboard/views/splash_screen.dart';
import 'package:supabase_example/provider/provider.dart';
import 'package:supabase_example/utils/constants.dart';
import 'package:supabase_example/utils/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'modules/auth/view/login_screen.dart';
import 'modules/auth/view/signup_screen.dart';
import 'modules/dashboard/views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: Constants.supabaseUrl,
    anonKey: Constants.apiKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataHandlerProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        builder: EasyLoading.init(),
        initialRoute: Routes.splashScreen,
        routes: {
          Routes.signupScreen: (context) => const SignupScreen(),
          Routes.loginScreen: (context) => const LoginScreen(),
          Routes.homeScreen: (context) => const HomeScreen(),
          Routes.splashScreen: (context) => const SplashScreen(),
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:supabase_chat_application/app/utils/themes/themes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/modules/auth/view/login_screen.dart';
import 'app/modules/auth/view/signup_screen.dart';
import 'app/modules/chat/view/chat_screen.dart';
import 'app/modules/onboard/view/splash_screen.dart';
import 'app/utils/constants/constants.dart';
import 'app/utils/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: Constants.supabaseUrl,
    anonKey: Constants.apiKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: AppThemes().appTheme,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      initialRoute: Routes.splashScreen,
      routes: {
        Routes.splashScreen: (context) =>  const SplashScreen(),
        Routes.signupScreen: (context) => const SignUpScreen(),
        Routes.loginScreen: (context) => const LoginScreen(),
        Routes.chatScreen: (context) => const ChatScreen(),
      },
    );
  }
}



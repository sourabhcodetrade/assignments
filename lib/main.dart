import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc/app/controllers/firebase_controller.dart';
import 'package:mvc/app/controllers/notification_controller.dart';
import 'package:mvc/app/modules/auth/controller/auth_controller.dart';
import 'package:mvc/app/modules/list/view/list_screen.dart';
import 'package:mvc/app/modules/settings/view/setting_screen.dart';
import 'package:mvc/app/utils/helper/wrapper.dart';
import 'package:mvc/app/utils/theme/theme.dart';
import 'package:provider/provider.dart';
import 'app/modules/auth/view/login_screen.dart';
import 'app/modules/auth/view/signup_screen.dart';
import 'app/modules/dashboard/view/home_screen.dart';
import 'app/modules/onboard/view/splash_screen.dart';
import 'app/modules/settings/controller/theme_provider.dart';
import 'app/utils/routes/routes.dart';


  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(); 

void main() async {
  print('working');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyAQjEgN2n22yyQVBFinR3AaRxrFeajNuTc',
    appId: '1:179303071162:android:e237babe971737513cb183',
    messagingSenderId: '179303071162',
    projectId: 'mvcapp-540be',
    storageBucket: 'mvcapp-540be.appspot.com',
  ));
  await FirebaseController().initNotification();
  await NotificationController.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          Provider<AuthController>(
            create: (context) => AuthController(),
          ),
          ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(),
          )
        ],
        child: const MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
      return MaterialApp(
        navigatorKey: navigatorKey,
        themeMode: ThemeMode.system,
        theme: themeProvider.currentTheme,
        darkTheme: TAppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splashScreen,
        routes: {
          Routes.wrapper: (context) => const Wrapper(),
          Routes.splashScreen: (context) => const SplashScreen(),
          Routes.signupScreen: (context) => const SignupScreen(),
          Routes.loginScreen: (context) => const LoginScreen(),
          Routes.homeScreen: (context) => const HomeScreen(),
          Routes.settingsScreen: (context) => const SettingScreen(),
          Routes.listScreen: (context) => const ListScreen(),
        },
      );
    });
  }
}

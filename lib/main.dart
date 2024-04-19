import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:supabase_example/modules/onboard/views/splash_screen.dart';
import 'package:supabase_example/utils/constants.dart';
import 'package:supabase_example/utils/routes.dart';
import 'modules/auth/view/login_screen.dart';
import 'modules/auth/view/signup_screen.dart';
import 'modules/dashboard/views/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: Constats.supabaseUrl,
    anonKey: Constats.apiKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(),
      link: HttpLink(Constats.graphql,
          defaultHeaders: {
            'apiKey':
                Constats.apiKey,
          }),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        navigatorKey: globalNavigatorKey,
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

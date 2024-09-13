import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtm/gtm.dart';
import 'package:mvc/app/utils/routes/routes.dart';
import 'package:provider/provider.dart';
import '../../auth/controller/auth_controller.dart';
import '../../auth/models/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    analytics.setAnalyticsCollectionEnabled(true);

    try {
      final gtm = Gtm.instance
        ..setCustomTagTypes([
          CustomTagType(
            'amplitude',
            handler: (eventName, parameters) {
              print('amplitude!');
              print(eventName);
              print(parameters);
            },
          ),
        ]);
      gtm.push(
        'test',
        parameters: {
          'user_no': 912342,
        },
      );
      gtm.push(
        'readCase',
        parameters: {
          'user_no': 912342,
          'user_type': 2,
        },
      );
      gtm.push(
        'buyEduCamp',
        parameters: {
          'user_no': 912342,
          'price': 10000.0,
        },
      );
    } on PlatformException {
      print('exception occurred!');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await analytics.logEvent(
                name: 'pages_tracked',
                parameters: {'page_name': 'setting_screen'},
              );
              Navigator.pushNamed(context, Routes.settingsScreen);
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            StreamBuilder<User?>(
              stream: authController.user, // Stream of User objects
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data != null) {
                  return Text(
                    'User Email: ${snapshot.data!.email}',
                    style: const TextStyle(fontSize: 16),
                  );
                } else {
                  return const Text('No user logged in');
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                await authController.signOut();
                await analytics.logEvent(
                  name: 'pages_tracked',
                  parameters: {'page_name': 'log_out'},
                );
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.loginScreen, (Route<dynamic> route) => false);
                }
              },
              child: const Text(
                'Logout',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                // await authController.signOut();
                await analytics.logEvent(
                  name: 'pages_tracked',
                  parameters: {'page_name': 'list_screen'},
                );
                if (context.mounted) {
                  Navigator.of(context).pushNamed(Routes.listScreen);
                }
              },
              child: const Text(
                'List Screen',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

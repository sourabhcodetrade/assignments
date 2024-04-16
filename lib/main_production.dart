import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
    apiKey: 'AIzaSyAeBOCeNxX9rNcyyJRRhc5E2RR7OT17g-8',
    appId: '1:1000710555828:android:8086b9c4ee30b2682d6fe1',
    messagingSenderId: '1000710555828',
    projectId: 'flavor-production-e2500',
    storageBucket: 'flavor-production-e2500.appspot.com',
  ));
  runApp(const App(title: "Production",));
}






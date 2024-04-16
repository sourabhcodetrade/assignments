import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCn8-Ga3TnzwPX5RZlYVEh0D6H9lXXlzco',
    appId: '1:340096714550:android:8c0ca087e70a9c1b085597',
    messagingSenderId: '340096714550',
    projectId: 'flavor-dev-679fe',
    storageBucket: 'flavor-dev-679fe.appspot.com',
  ));
  runApp(const App(
    title: "Development",
  ));
}

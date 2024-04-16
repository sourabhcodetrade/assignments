import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
    apiKey: 'AIzaSyCL0RAwQHMV3lTLtNOqU47q2LDsDJ3Bv88',
    appId: '1:220627267419:android:124adc68454579988cf47e',
    messagingSenderId: '220627267419',
    projectId: 'flavor-staging-83656',
    storageBucket: 'flavor-staging-83656.appspot.com',
  ));
  runApp(const App(
    title: "Staging",
  ));
}

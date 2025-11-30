import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'features/home/homepage.dart';
// Import this after running: flutterfire configure
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naknaa Music Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Arial',
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 14)),
      ),
      home: const NaknaaHomePage(),
    );
  }
}

import 'package:flutter/material.dart';

import 'features/home/homepage.dart';
// Import this after running: flutterfire configure
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  // Uncomment the line below after running 'flutterfire configure'
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // For now, use this (will be replaced after flutterfire configure):

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

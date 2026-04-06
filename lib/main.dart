import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/home/homepage.dart';
import 'core/services/cart_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CartService())],
      child: MaterialApp(
        title: 'Naknaa-Oline',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Arial',
          textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 14)),
        ),
        home: const NaknaaHomePage(),
      ),
    );
  }
}

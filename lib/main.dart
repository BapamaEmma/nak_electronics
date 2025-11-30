import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'features/home/homepage.dart';
import 'features/product/product_list_page.dart';
import 'features/product/product_detail_page.dart';
import 'models/product.dart';
import 'core/services/cart_service.dart';
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
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CartService())],
      child: MaterialApp(
        title: 'Naknaa Music Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Arial',
          textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 14)),
        ),
        home: const NaknaaHomePage(),
        routes: {
          '/products': (context) {
            final args =
                ModalRoute.of(context)!.settings.arguments
                    as Map<String, dynamic>;
            return ProductListPage(
              filterType: args['filterType'] as String,
              filterValue: args['filterValue'] as String,
            );
          },
          '/product_detail': (context) {
            final product =
                ModalRoute.of(context)!.settings.arguments as Product;
            return ProductDetailPage(product: product);
          },
        },
      ),
    );
  }
}

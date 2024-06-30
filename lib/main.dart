import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fresh_mart_app/Admin/add_product.dart';
import 'package:fresh_mart_app/pages/bottomnav.dart';
import 'package:fresh_mart_app/services/constant.dart';
// import 'package:fresh_mart_app/Admin/admin_login.dart';
import 'pages/login.dart';
// import 'pages/product_detail.dart';
// import 'pages/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Stripe.publishableKey = publishablekey;
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => LoginScreen(),
        // other routes
      },
      title: 'Fresh Mart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}

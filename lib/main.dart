import 'package:flutter/material.dart';
import 'package:kasim/model/product_model.dart';
import 'package:kasim/provider/auth_provider.dart';
import 'package:kasim/provider/cart_provider.dart';
import 'package:kasim/provider/user_provider.dart';
import 'package:kasim/screen/cart_screen.dart';
import 'package:kasim/screen/login_screen.dart';
import 'package:kasim/screen/product_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Provider Cart Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
    );
  }
}
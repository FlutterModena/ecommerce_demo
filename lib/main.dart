import 'package:ecommerce_demo/app_bloc.dart';
import 'package:ecommerce_demo/data/models.dart';
import 'package:ecommerce_demo/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    AppBLoC(
      cart: CartObservable(Cart()),
      child: const EcommerceApp(),
    ),
  );
}

/// Widget principale dell'applicazione.
class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommerce Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

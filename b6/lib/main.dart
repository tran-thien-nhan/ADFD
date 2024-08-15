import 'package:b6/providers/ProductProvider.dart';
import 'package:b6/screens/ProductScreen.dart';
import 'package:b6/screens/ProductForm.dart'; // Import the ProductForm screen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ProductProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const ProductScreen(),
        "/form-product": (context) => const ProductForm(),
      },
    );
  }
}

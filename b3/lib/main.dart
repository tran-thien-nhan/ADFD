import 'package:b3/screens/ProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b3/providers/ProductProvider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => Productprovider(), child: const MyApp()));
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
      home: const ProductScreen(),
    );
  }
}

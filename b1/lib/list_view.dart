import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List View',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'App Counter',
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custome list item sample"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(child: Text("A")),
            title: Text("chao long"),
            subtitle: Text("delicous, ngon"),
            trailing: Icon(Icons.favorite_border),
          ),
          ListTile(
            leading: CircleAvatar(child: Text("B")),
            title: Text("hủ tiếu"),
            subtitle: Text("good"),
            trailing: Icon(Icons.airline_seat_flat),
          )
        ],
      ),
    );
  }
}

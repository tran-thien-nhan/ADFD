import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: ListItemExample(),
    );
  }
}

class ListItemExample extends StatelessWidget {
  final List<Map<String, dynamic>> list = [
    {
      'title': 'Item 1',
      'description': 'Description 1',
      "icon": Icons.favorite,
    },
    {
      'title': 'Item 2',
      'description': 'Description 2',
      "icon": Icons.star,
    },
    {
      'title': 'Item 3',
      'description': 'Description 3',
      "icon": Icons.info,
    },
  ];
  ListItemExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custome List Item Example'),
      ),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, index) {
            final keyValue = list[index];
            return Column(
              children: [
                ListTile(
                  title: Text(keyValue['title']),
                  subtitle: Text(keyValue['description']),
                  trailing: Icon(keyValue['icon']),
                  onTap: () {
                    // Handle item tap here
                    dialogDetail(context, keyValue);
                  },
                ),
                Divider(), // Add a divider between list items
              ],
            );
          }),
    );
  }

  void dialogDetail(BuildContext context, Map<String, dynamic> keyValue) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(keyValue['title']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Title: ${keyValue['title']}"),
              Text("Description: ${keyValue['description']}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

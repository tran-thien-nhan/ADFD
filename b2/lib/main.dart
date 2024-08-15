import 'package:b2/widgets/DateTimePickerSimple.dart';
import 'package:b2/widgets/FormProduct.dart';
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
      home: const MyTabBarApp(),
    );
  }
}

class MyTabBarApp extends StatefulWidget {
  const MyTabBarApp({super.key});

  @override
  State<MyTabBarApp> createState() => _MyTabBarAppState();
}

class _MyTabBarAppState extends State<MyTabBarApp>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  void switchTab(index) {
    setState(() {
      _tabController.animateTo(index,
          duration: const Duration(milliseconds: 200));
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TabBar Example"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.beach_access_outlined)),
            Tab(icon: Icon(Icons.home_filled)),
            Tab(icon: Icon(Icons.local_cafe)),
            Tab(icon: Icon(Icons.pending_actions)),
            Tab(icon: Icon(Icons.production_quantity_limits)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                switchTab(1);
              },
              child: const Text("Switch to Tab 2"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                switchTab(2);
              },
              child: const Text("Switch to Tab 3"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                switchTab(0);
              },
              child: const Text("Switch to Tab 1"),
            ),
          ),
          Center(
            child: Datetimepickersimple(),
          ),
          Center(
            child: FormProduct(),
          ),
        ],
      ),
    );
  }
}

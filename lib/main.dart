import 'package:flutter/material.dart';
import 'screens/sofia_screen.dart';
import 'screens/sources_screen.dart';

void main() {
  runApp(RefereeIQApp());
}

class RefereeIQApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RefereeIQ',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("RefereeIQ"),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: "Sources"),
              Tab(text: "Ask Sofia"),
              Tab(text: "Shop"),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            SourcesScreen(),
            SofiaScreen(),
            Center(child: Text("Shop Tab")),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'screens/sofia_screen.dart';
import 'screens/sources_screen.dart';
import 'screens/shop_screen.dart';      // Placeholder; implement as needed.
import 'screens/fav_screen.dart';       // Placeholder; implement as needed.
import 'screens/challenge_screen.dart'; // Placeholder; implement as needed.

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
    // 4 tabs: Sources, Ask Sofia, Challenge, Fav.
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Drawer for additional navigation (e.g., Shop and Logout)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer header
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFFADC44), // Custom yellow.
              ),
              child: Text(
                'RefereeIQ Menu',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            // ListTile for Shop.
            ListTile(
              leading: Icon(Icons.store),
              title: Text('Shop'),
              onTap: () {
                Navigator.pop(context); // Close the drawer.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShopScreen()),
                );
              },
            ),
            // ListTile for Logout.
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pop(context); // Close the drawer.
                // Implement your logout logic here.
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFFADC44), // Custom yellow header.
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Group logo and app name together.
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black,
              child: Icon(Icons.sports_rugby, color: Colors.white),
            ),
            SizedBox(width: 8),
            Text(
              'RefereeIQ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black,
          indicator: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
          ),
          tabs: [
            Tab(icon: Icon(Icons.book), text: 'Sources'),
            Tab(icon: Icon(Icons.message), text: 'Ask Sofia'),
            Tab(icon: Icon(Icons.campaign), text: 'Challenge'),
            Tab(icon: Icon(Icons.star), text: 'Fav'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SourcesScreen(),
          SofiaScreen(),
          ChallengeScreen(), // Implement as needed or use a placeholder.
          FavScreen(),       // Implement as needed or use a placeholder.
        ],
      ),
    );
  }
}

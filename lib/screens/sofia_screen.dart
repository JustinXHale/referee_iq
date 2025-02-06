import 'package:flutter/material.dart';
import 'sources_screen.dart';
import 'shop_screen.dart'; // Placeholder; implement as needed.
import 'fav_screen.dart';  // Placeholder; implement as needed.
import 'challenge_screen.dart'; // Placeholder; implement as needed.
import 'home_screen.dart'; // Import HomeScreen to navigate back on Logout

class SofiaScreen extends StatefulWidget {
  @override
  _SofiaScreenState createState() => _SofiaScreenState();
}

class _SofiaScreenState extends State<SofiaScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController inputController = TextEditingController();
  final List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Simulate sending a message and getting a response from Sofia
  void handleUserInput(String input) {
    if (input.isEmpty) return;

    setState(() {
      // Add user message to the list
      messages.add({"type": "user", "text": input});

      // Simulate a response from Sofia
      messages.add({"type": "sofia", "text": "This is a response from Sofia!"});
    });

    inputController.clear(); // Clear the input field
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFADC44),
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFFADC44),
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
            ListTile(
              leading: Icon(Icons.store),
              title: Text('Shop'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShopScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to Profile Screen
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()), // Navigate back to HomeScreen
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // TabBarView to hold the different tabs
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SourcesScreen(),       // Tab 1: Sources
                Column(                // Tab 2: Ask Sofia
                  children: [
                    // Chat message area.
                    Expanded(
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          return Align(
                            alignment: message["type"] == "user"
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: message["type"] == "user"
                                    ? Colors.blue[100]
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(message["text"]!),
                            ),
                          );
                        },
                      ),
                    ),
                    // Input field
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: inputController,
                        decoration: InputDecoration(
                          hintText: "Type your question...",
                          filled: true,
                          fillColor: Color(0xFFFADC44),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send, color: Colors.black),
                            onPressed: () {
                              handleUserInput(inputController.text);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ChallengeScreen(),     // Tab 3: Challenge
                FavScreen(),           // Tab 4: Fav
              ],
            ),
          ),
        ],
      ),
    );
  }
}

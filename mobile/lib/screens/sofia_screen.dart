import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;  // Importing the http package
import 'dart:convert';
import 'sources_screen.dart';         // For the Sources Tab
import 'shop_screen.dart';            // For the Shop Tab (placeholder)
import 'fav_screen.dart';             // For the Fav Tab (placeholder)
import 'challenge_screen.dart';      // For the Challenge Tab (placeholder)
import 'home_screen.dart';           // For navigating back to the home screen

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
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1); // Set "Ask Sofia" as default tab
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Handle sending the user's input and getting the response from the backend
  void handleUserInput(String input) async {
    if (input.isEmpty) return;

    setState(() {
      // Add user message to the list
      messages.add({"type": "user", "text": input});
    });

    inputController.clear(); // Clear the input field

    try {
      // Send the input to the backend and get the response
      var response = await sendQueryToBackend(input);
      
      setState(() {
        // Add Sofia's response to the list
        messages.add({
          "type": "sofia",
          "text": response['response'],  // The main response
          "law_reference": response['law_reference'], // Law Reference
          "source_link": response['source_link'], // Source Link to World Rugby
        });
      });
    } catch (error) {
      print("Error occurred: $error");
      setState(() {
        // Handle error (Optional: display an error message)
        messages.add({"type": "sofia", "text": "Sorry, something went wrong!"});
      });
    }
  }

  // Function to send the query to FastAPI
  Future<Map<String, dynamic>> sendQueryToBackend(String query) async {
    final url = 'http://10.0.2.2:8000/query';  // Change to this when using Android Emulator

    try {
      print("Sending query: $query");  // Debugging: Log the query being sent
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'query': query}),
      );

      print("Received response: ${response.body}");  // Debugging: Log the response from backend

      if (response.statusCode == 200) {
        // Parse the JSON response
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load response');
      }
    } catch (e) {
      print("Error: $e");  // Debugging: Log any error
      throw Exception('Error: $e');
    }
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
                // Tab 2: Ask Sofia
                Column(
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
                                    : Color(0xFF212121),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                crossAxisAlignment: message["type"] == "user"
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    message["text"]!,  // Display the main response text
                                    style: TextStyle(
                                      color: message["type"] == "user"
                                          ? Colors.black // Change text color for user message
                                          : Colors.white, // Change text color for Sofia's response
                                    ),
                                  ),
                                  if (message["type"] == "sofia") ...[
                                    if (message["law_reference"] != null) ...[
                                      SizedBox(height: 5),
                                      Text(
                                        "Law Reference: ${message["law_reference"]}",
                                        style: TextStyle(fontSize: 12, color: Colors.white),
                                      ),
                                    ],
                                    if (message["source_link"] != null) ...[
                                      SizedBox(height: 5),
                                      Text(
                                        "Source: ${message["source_link"]}",
                                        style: TextStyle(fontSize: 12, color: Colors.blue),
                                      ),
                                    ],
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Input field with flexible text wrapping
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
                        maxLines: null, // Allow the text field to grow vertically
                        minLines: 1,    // Start with 1 line
                      ),
                    )
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

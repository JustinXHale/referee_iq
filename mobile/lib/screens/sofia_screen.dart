import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'sources_screen.dart'; 
import 'shop_screen.dart';
import 'fav_screen.dart';
import 'challenge_screen.dart';
import 'home_screen.dart';

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

  // Handle sending the user's input and getting the response from the backend
  void handleUserInput(String input) async {
    if (input.isEmpty) return;

    setState(() {
      messages.add({"type": "user", "text": input});
    });

    inputController.clear();

    try {
      var response = await sendQueryToBackend(input);
      setState(() {
        messages.add({
          "type": "sofia",
          "text": response['response'],
          "law_reference": response['law_reference'],
          "source_link": response['source_link'],
        });
      });
    } catch (error) {
      print("Error occurred: $error");
      setState(() {
        messages.add({"type": "sofia", "text": "Sorry, something went wrong!"});
      });
    }
  }

  Future<Map<String, dynamic>> sendQueryToBackend(String query) async {
    final url = 'http://10.0.2.2:8000/query';  // Use appropriate backend URL

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'query': query}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load response');
      }
    } catch (e) {
      print("Error: $e");
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
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
              decoration: BoxDecoration(color: Color(0xFFFADC44)),
              child: Text(
                'RefereeIQ Menu',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            ListTile(
              leading: Icon(Icons.store),
              title: Text('Shop'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ShopScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Profile Screen
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SourcesScreen(),  // Tab 1: Sources
                buildChatScreen(), // Tab 2: Ask Sofia
                ChallengeScreen(),  // Tab 3: Challenge
                FavScreen(),  // Tab 4: Fav
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Chat Screen for 'Ask Sofia'
  Widget buildChatScreen() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              return Align(
                alignment: message["type"] == "user" ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: message["type"] == "user" ? Colors.blue[100] : Color(0xFF212121),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: message["type"] == "user"
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        message["text"]!,
                        style: TextStyle(
                          color: message["type"] == "user" ? Colors.black : Colors.white,
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
            maxLines: null,  // Allow the text field to grow vertically
            minLines: 1,     // Start with 1 line
          ),
        )
      ],
    );
  }
}

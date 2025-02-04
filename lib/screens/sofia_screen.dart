import 'package:flutter/material.dart';
import 'sources_screen.dart';
import 'home_screen.dart'; // For log out navigation.
import 'ChatFlow.dart';

class SofiaScreen extends StatefulWidget {
  @override
  _SofiaScreenState createState() => _SofiaScreenState();
}

class _SofiaScreenState extends State<SofiaScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // Example chat messages list for the "Ask Sofia" tab.
  final List<Map<String, dynamic>> messages = [];
  final TextEditingController inputController = TextEditingController();
  final ChatFlow chatFlow = ChatFlow();

  @override
  void initState() {
    super.initState();
    // We have 4 tabs: Sources, Ask Sofia, Shop, Fav.
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    inputController.dispose();
    super.dispose();
  }

  void handleUserInput(String input) {
    if (input.isEmpty) return;

    setState(() {
      messages.add({"type": "user", "text": input});
    });

    final response = chatFlow.getResponse(input.trim());
    if (response != null) {
      setState(() {
        messages.add({"type": "sofia", "text": response["response"]});
        if (response["links"] != null) {
          for (var link in response["links"]) {
            messages.add({"type": "link", "text": link["text"], "url": link["url"]});
          }
        }
      });
    } else {
      setState(() {
        messages.add({"type": "sofia", "text": "Sorry, I don’t have an answer for that yet."});
      });
    }

    inputController.clear();
  }

  void handleProfileAction(String action) {
    if (action == 'Log Out') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );
    } else if (action == 'Profile') {
      // TODO: Navigate to Profile Page.
      print('Profile selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Persistent header
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo placeholder.
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.insert_emoticon, color: Colors.white),
            ),
            // App name.
            Text(
              'RefereeIQ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
            ),
            // Profile photo placeholder.
            PopupMenuButton<String>(
              onSelected: handleProfileAction,
              icon: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.account_circle, color: Colors.white),
              ),
              offset: Offset(0, 40),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              itemBuilder: (context) => [
                PopupMenuItem(value: 'Profile', child: Text('Profile')),
                PopupMenuItem(value: 'Log Out', child: Text('Log Out')),
              ],
            ),
          ],
        ),
        // TabBar under the header.
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          tabs: [
            Tab(icon: Icon(Icons.book), text: 'Sources'),
            Tab(icon: Icon(Icons.message), text: 'Ask Sofia'),
            Tab(icon: Icon(Icons.store), text: 'Shop'),
            Tab(icon: Icon(Icons.star), text: 'Fav'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // For the Sources tab, you can use your SourcesScreen.
          SourcesScreen(),
          // For the Ask Sofia tab, show a simple chat interface.
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    if (message["type"] == "link") {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            // TODO: Open link.
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              message["text"],
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      );
                    }
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: inputController,
                  onSubmitted: handleUserInput,
                  decoration: InputDecoration(
                    hintText: "Type your question...",
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send, color: Colors.blue),
                      onPressed: () {
                        handleUserInput(inputController.text);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          // For the Shop tab.
          Center(child: Text('Shop Tab Content')),
          // For the Fav tab.
          Center(child: Text('Fav Tab Content')),
        ],
      ),
    );
  }
}

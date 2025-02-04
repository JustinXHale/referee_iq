import 'package:flutter/material.dart';
import 'ChatFlow.dart';
import 'home_screen.dart'; // For log out navigation

class SofiaScreen extends StatefulWidget {
  @override
  _SofiaScreenState createState() => _SofiaScreenState();
}

class _SofiaScreenState extends State<SofiaScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController inputController = TextEditingController();
  final List<Map<String, dynamic>> messages = [];
  final ChatFlow chatFlow = ChatFlow();

  @override
  void initState() {
    super.initState();
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
      // TODO: Navigate to Profile Page
      print('Profile selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.insert_emoticon, color: Colors.white),
              ),
              Text(
                'RefereeIQ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
              ),
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
                  PopupMenuItem(
                    value: 'Profile',
                    child: Text('Profile'),
                  ),
                  PopupMenuItem(
                    value: 'Log Out',
                    child: Text('Log Out'),
                  ),
                ],
              ),
            ],
          ),
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: Colors.blue, width: 2),
              insets: EdgeInsets.symmetric(horizontal: 30),
            ),
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
            Center(child: Text('Sources Tab')),
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
                              // TODO: Open link
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
                                style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
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
            Center(child: Text('Shop Tab')),
            Center(child: Text('Fav Tab')),
          ],
        ),
      ),
    );
  }
}

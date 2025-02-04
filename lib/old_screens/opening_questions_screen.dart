import 'package:flutter/material.dart';
import 'home_screen.dart'; // Make sure HomeScreen is imported correctly

class OpeningQuestionsScreen extends StatefulWidget {
  @override
  _OpeningQuestionsScreenState createState() => _OpeningQuestionsScreenState();
}

class _OpeningQuestionsScreenState extends State<OpeningQuestionsScreen> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Placeholder for a logo
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.insert_emoticon, color: Colors.white),
              ),
              // App name
              Text(
                'RefereeIQ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // Profile Dropdown
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == "Profile") {
                    // Navigate to Profile screen
                    print("Profile selected");
                    // TODO: Add navigation to Profile screen here
                  } else if (value == "Log Out") {
                    // Show confirmation dialog for logout
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Log Out"),
                        content: Text("Are you sure you want to log out?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close dialog
                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close dialog
                              // Navigate back to the home screen
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen()),
                                (route) => false,
                              );
                            },
                            child: Text("Log Out"),
                          ),
                        ],
                      ),
                    );
                  }
                },
                icon: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.account_circle, color: Colors.white),
                ),
                offset: Offset(0, 30), // Adjusts the dropdown position
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: "Profile",
                    child: Text("Profile"),
                  ),
                  PopupMenuItem(
                    value: "Log Out",
                    child: Text("Log Out"),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Material Design Tabs
              TabBar(
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(fontWeight: FontWeight.w600),
                indicatorColor: Theme.of(context).primaryColor,
                tabs: [
                  Tab(text: 'Resources'),
                  Tab(text: 'Chat with Sofia'),
                  Tab(text: 'Shop'),
                ],
              ),
              Divider(height: 1, color: Colors.grey[300]),

              // Title and Subtext
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        "Question or scenario? I’m here to help!",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Try: What happens if a player tackles above the shoulders?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),

              // Question of the Day Chip
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Chip(
                  label: Text("Question of the Day"),
                  backgroundColor: Colors.blue[100],
                ),
              ),
              SizedBox(height: 20),

              // Bottom Text Field
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey[300]!),
                        ),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          // Text input field
                          Expanded(
                            child: TextField(
                              focusNode: _focusNode,
                              decoration: InputDecoration(
                                hintText: "Type your question...",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          // Send button
                          IconButton(
                            icon: Icon(Icons.send, color: Colors.blue),
                            onPressed: () {
                              // TODO: Handle send action
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

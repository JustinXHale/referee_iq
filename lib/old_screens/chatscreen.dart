import 'package:flutter/material.dart';
import 'ChatFlow.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatFlow chatFlow = ChatFlow();
  final List<Map<String, String>> chatHistory = [];
  final TextEditingController inputController = TextEditingController();

  void handleUserInput(String input) {
    setState(() {
      // Add user input to chat history
      chatHistory.add({"type": "user", "text": input});
    });

    // Get Sofia's response
    final response = chatFlow.getResponse(input);
    if (response != null) {
      setState(() {
        // Add Sofia's response to chat history
        chatHistory.add({"type": "sofia", "text": response["response"]});
      });
    } else {
      setState(() {
        // Add a default response if no match is found
        chatHistory.add({
          "type": "sofia",
          "text": "Sorry, I don’t have an answer for that yet."
        });
      });
    }

    // Clear the text field
    inputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("RefereeIQ Chat")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatHistory.length,
              itemBuilder: (context, index) {
                final chatItem = chatHistory[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: chatItem["type"] == "user"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: chatItem["type"] == "user"
                            ? Colors.blue[100]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(chatItem["text"]!),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
  controller: inputController,
  onSubmitted: (input) {
    print("Submitted: $input");
    if (input.isNotEmpty) {
      handleUserInput(input);
    }
  },
  decoration: InputDecoration(
    hintText: "Type your question...",
    border: OutlineInputBorder(),
  ),
),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    final input = inputController.text;
                    if (input.isNotEmpty) {
                      handleUserInput(input);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
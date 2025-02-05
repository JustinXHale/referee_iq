import 'package:flutter/material.dart';
import 'ChatFlow.dart'; // Ensure ChatFlow.dart is in the same directory

class SofiaScreen extends StatefulWidget {
  @override
  _SofiaScreenState createState() => _SofiaScreenState();
}

class _SofiaScreenState extends State<SofiaScreen> {
  final TextEditingController inputController = TextEditingController();
  final List<Map<String, dynamic>> messages = [];
  final ChatFlow chatFlow = ChatFlow();

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
            messages.add({
              "type": "link",
              "text": link["text"],
              "url": link["url"]
            });
          }
        }
      });
    } else {
      setState(() {
        messages.add({
          "type": "sofia",
          "text": "Sorry, I don’t have an answer for that yet."
        });
      });
    }
    inputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Chat message area.
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
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
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
        // Input field.
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
                icon: Icon(Icons.send, color: Colors.black),
                onPressed: () {
                  handleUserInput(inputController.text);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

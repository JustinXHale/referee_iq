import 'package:http/http.dart' as http;
import 'dart:convert';  // For converting the response to a JSON

// Your backend URL (for local testing, you can use localhost or 127.0.0.1)
// If you deploy your backend to a server, update this URL with your server's address
const String apiUrl = 'http://10.0.2.2:8000/query';  // Updated for Android Emulator

// Function to send user input to the FastAPI backend and return the response
Future<Map<String, dynamic>> sendQueryToBackend(String userInput) async {
  // Prepare the request body as a map
  final Map<String, dynamic> requestBody = {
    'query': userInput,  // Replace 'query' with the actual parameter your FastAPI endpoint expects
  };

  // Convert the body to JSON
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(requestBody),
  );

  // Check the response status
  if (response.statusCode == 200) {
    // If the response is successful, parse and return the data
    final responseData = json.decode(response.body);
    print('Response data: $responseData');  // Log the response data for debugging
    return responseData;  // Return the parsed data
  } else {
    // If the response is not successful, throw an exception
    throw Exception('Failed to send request: ${response.statusCode}');
  }
}

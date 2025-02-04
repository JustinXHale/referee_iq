import 'package:flutter/material.dart';
import 'opening_questions_screen.dart'; // Make sure this is imported

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Welcome text
            Text(
              'Welcome to RefereeIQ',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            // Subtext
            Text(
              'RefereeIQ helps you easily navigate rugby laws and find answers to common referee questions.',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),

            // Email field
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),

            // Password field
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),

            // Login Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => OpeningQuestionsScreen()),
                );
              },
              child: Text("Login"),
            ),
            SizedBox(height: 20),

            // Continue with Google button
            ElevatedButton(
              onPressed: () {
                // TODO: Handle Google sign-in
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(color: Colors.grey),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.account_circle, color: Colors.grey),
                  SizedBox(width: 10),
                  Text(
                    'Continue with Google',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),

            // Sign Up with Email button
            ElevatedButton(
              onPressed: () {
                // TODO: Navigate to sign-up screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                'Sign Up with Email',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 15),

            // Continue as guest link
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OpeningQuestionsScreen(),
                  ),
                );
              },
              child: Text("Continue as guest"),
            ),
          ],
        ),
      ),
    );
  }
}

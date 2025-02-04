import 'package:flutter/material.dart';
import 'sofia_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 60),
              // Logo placeholder
              Icon(Icons.sports_rugby, size: 100, color: Colors.blue),
              SizedBox(height: 20),
              Text(
                'Welcome to RefereeIQ',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'RefereeIQ helps you easily navigate rugby laws and find answers to common referee questions.',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the SofiaScreen on login.
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SofiaScreen()),
                  );
                },
                child: Text("Login"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // TODO: Handle Google sign-in if needed.
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
                    Text('Continue with Google', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to sign-up screen if needed.
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text('Sign Up with Email', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SofiaScreen()),
                  );
                },
                child: Text("Continue as guest"),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

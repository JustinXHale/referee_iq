import 'package:flutter/material.dart';
import 'sofia_screen.dart'; // Import SofiaScreen

/// Custom Google Sign-In Button widget (inline)
class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  const GoogleSignInButton({Key? key, required this.onPressed}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // white background
        foregroundColor: Colors.black, // text color
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        elevation: 2,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/google_logo.png',
            height: 24.0,
          ),
          SizedBox(width: 12),
          Text(
            'Continue with Google',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define your custom yellow. Ensure the full 8-digit hex code is provided.
    final Color customYellow = Color(0xFFFADC44); 

    return Scaffold(
      backgroundColor: customYellow,
      body: SafeArea(
        child: Stack(
          children: [
            // Top left header: "RefereeIQ"
            Positioned(
              top: 0,
              left: 16,
              child: Text(
                'RefereeIQ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            // Lower third section
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  // Use mainAxisSize.min so that the column only takes up as much vertical space as needed.
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Line 1: Welcome text
                    Text(
                      'Welcome to RefereeIQ',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    // Line 2: Description text
                    Text(
                      'Helping you navigate rugby laws and find answers to your questions & scenarios',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    // Continue with Google Button
                    GoogleSignInButton(
                      onPressed: () {
                        // Implement Google sign-in functionality.
                      },
                    ),
                    SizedBox(height: 15),
                    // Sign Up with Email Button (full width)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Navigate to sign-up screen if needed.
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text(
                          'Sign Up with Email',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    // Continue as Guest Link
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SofiaScreen()),
                        );
                      },
                      child: Text("Continue as guest", style: TextStyle(fontSize: 16, color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'screens/sofia_screen.dart';
import 'screens/sources_screen.dart';
import 'screens/shop_screen.dart'; // Placeholder; implement as needed.
import 'screens/fav_screen.dart';  // Placeholder; implement as needed.
import 'screens/challenge_screen.dart'; // Placeholder; implement as needed.
import 'screens/home_screen.dart'; // Import HomeScreen

void main() {
  runApp(RefereeIQApp());
}

class RefereeIQApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RefereeIQ',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(), // Start with HomeScreen
    );
  }
}

// Splash Screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay (e.g., loading assets) before moving to HomeScreen.
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()), // Navigate to HomeScreen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Display loading spinner or splash content
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(RefereeIQApp());
}

class RefereeIQApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RefereeIQ',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(), // Start at the login/welcome screen.
    );
  }
}

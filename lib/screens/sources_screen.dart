import 'package:flutter/material.dart';

class SourcesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sources'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/head-contact-process.png',
              errorBuilder: (context, error, stackTrace) {
                return Text(
                  'Unable to load the image.',
                  style: TextStyle(color: Colors.red),
                );
              },
            ),
            SizedBox(height: 20),
            Text('For more details, visit:'),
            GestureDetector(
              onTap: () {
                // Add link functionality
              },
              child: Text(
                'https://head-contact.example',
                style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

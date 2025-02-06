import 'package:flutter/material.dart';

// Dummy screens for Daily Challenge and Leaderboard.
class DailyChallengeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Daily Challenge Content',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class LeaderboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Leaderboard Content',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class ChallengeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two sub-tabs: Daily Challenge and Leaderboard.
      child: Column(
        children: [
          // The nested TabBar.
          Container(
            color: Colors.white,
            child: TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              tabs: [
                Tab(text: 'Daily Challenge'),
                Tab(text: 'Leaderboard'),
              ],
            ),
          ),
          // The nested TabBarView.
          Expanded(
            child: TabBarView(
              children: [
                DailyChallengeScreen(),
                LeaderboardScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

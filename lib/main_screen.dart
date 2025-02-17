import 'package:flutter/material.dart';
import 'challenge_screen.dart';
import 'user.dart';
import 'daily_quest_screen.dart';
import 'models.dart';

class MainScreen extends StatefulWidget {
  final User user;

  MainScreen({required this.user});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<DailyQuest> quests = [
    DailyQuest(name: "Push-ups", goal: 100),
    DailyQuest(name: "Sit-ups", goal: 100),
    DailyQuest(name: "Chin-ups", goal: 50),
    DailyQuest(name: "Running", goal: 1),
  ];

  List<Challenge> challenges = [
    Challenge(description: "Run 5 km", rewardXP: 500),
    Challenge(description: "Complete 200 Push-ups", rewardXP: 500),
    Challenge(description: "Complete 150 Sit-ups", rewardXP: 500),
  ];

  void checkChallenges() {
    if (widget.user.level % 15 == 0 && widget.user.level <= 100 ||
        widget.user.level % 20 == 0 && widget.user.level <= 300 ||
        widget.user.level % 10 == 0 && widget.user.level > 300) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChallengeScreen(user: widget.user),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Not Available at this level"),
            content: Text(
              "Challenges are not available at your current level.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Solo Leveling Fitness")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "XP: ${widget.user.xp}",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Level: ${widget.user.level}",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Title: ${widget.user.title}",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          ListTile(
            title: Text("Daily Quests"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          DailyQuestScreen(user: widget.user, quests: quests),
                ),
              );
              setState(() {}); // Update state when returning
            },
          ),
        ],
      ),
    );
  }
}

// lib/challenge_screen.dart
import 'package:flutter/material.dart';
import 'models.dart';
import 'user.dart';

class ChallengeScreen extends StatefulWidget {
  final User user;

  ChallengeScreen({required this.user});

  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  List<Challenge> challenges = [
    Challenge(description: "Run 5 km", rewardXP: 500),
    Challenge(description: "Complete 200 Push-ups", rewardXP: 500),
    Challenge(description: "Complete 150 Sit-ups", rewardXP: 500),
  ];

  void completeChallenge(Challenge challenge) {
    setState(() {
      widget.user.addXP(
        challenge.rewardXP,
      ); // Reward XP for completing the challenge
      challenges.remove(challenge); // Remove the completed challenge
      widget.user.saveUserData(); // Save user data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Challenges")),
      body: ListView(
        children: [
          ...challenges.map((challenge) {
            return ListTile(
              title: Text(challenge.description),
              trailing: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Challenge Available!"),
                        content: Text(
                          "Would you like to complete this challenge to earn ${challenge.rewardXP} XP?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              completeChallenge(challenge);
                              Navigator.pop(context);
                            },
                            child: Text("Accept"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Decline"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text("Accept Challenge"),
              ),
            );
          }).toList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context); // Return to the previous screen
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}

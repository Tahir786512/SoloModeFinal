import 'package:flutter/material.dart';
import 'models.dart';
import 'user.dart';

class DailyQuestScreen extends StatefulWidget {
  final User user;
  final List<DailyQuest> quests;

  DailyQuestScreen({required this.user, required this.quests});

  @override
  _DailyQuestScreenState createState() => _DailyQuestScreenState();
}

class _DailyQuestScreenState extends State<DailyQuestScreen> {
  final TextEditingController pushupsController = TextEditingController();
  final TextEditingController situpsController = TextEditingController();
  final TextEditingController chinupsController = TextEditingController();
  final TextEditingController runningController = TextEditingController();

  @override
  void dispose() {
    pushupsController.dispose();
    situpsController.dispose();
    chinupsController.dispose();
    runningController.dispose();
    super.dispose();
  }

  void completeQuest(DailyQuest quest) {
    setState(() {
      if (!quest.isComplete()) {
        quest.progress = quest.goal;
        widget.user.addXP(10); // Add 10 XP for completing the quest
        widget.user.saveUserData(); // Save user data
      }
    });
  }

  void _addSet(String exercise, TextEditingController controller) {
    int count =
        controller.text.isNotEmpty
            ? int.parse(controller.text)
            : 0; // Prevent crash on empty input
    setState(() {
      DailyQuest quest = widget.quests.firstWhere(
        (quest) => quest.name == exercise,
      );
      quest.progress += count; // Instead of `quest.addProgress(count);`

      if (exercise == 'Push-ups' && quest.progress >= 100) {
        widget.user.addXP(10);
        quest.progress = 100; // Cap progress at 100
      } else if (exercise == 'Sit-ups' && quest.progress >= 100) {
        widget.user.addXP(10);
        quest.progress = 100;
      } else if (exercise == 'Chin-ups' && quest.progress >= 50) {
        widget.user.addXP(10);
        quest.progress = 50;
      } else if (exercise == 'Running' && quest.progress >= 1) {
        widget.user.addXP(10);
        quest.progress = 1;
      }

      widget.user.saveUserData(); // Save user data
    });

    controller.clear();
  }

  Widget _buildAddSetRow(String exercise, TextEditingController controller) {
    return ListTile(
      title: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: "Add $exercise set"),
      ),
      trailing: IconButton(
        icon: Icon(Icons.add),
        onPressed: () => _addSet(exercise, controller),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Quests"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "XP: ${widget.user.xp}",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          ...widget.quests.map((quest) {
            return ListTile(
              title: Text("${quest.name}: ${quest.progress}/${quest.goal}"),
              trailing: IconButton(
                icon: Icon(Icons.check),
                onPressed: () => completeQuest(quest),
              ),
            );
          }).toList(),
          _buildAddSetRow("Push-ups", pushupsController),
          _buildAddSetRow("Sit-ups", situpsController),
          _buildAddSetRow("Chin-ups", chinupsController),
          _buildAddSetRow("Running", runningController),
          ListTile(
            title: Text("Back to Main Screen"),
            trailing: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.pop(context); // Navigate back to the main screen
            },
          ),
        ],
      ),
    );
  }
}

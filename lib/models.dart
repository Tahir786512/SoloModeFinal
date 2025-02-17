// lib/models.dart
class DailyQuest {
  final String name;
  final int goal;
  int progress;

  DailyQuest({required this.name, required this.goal, this.progress = 0});

  bool isComplete() {
    return progress >= goal;
  }

  void addProgress(int amount) {
    progress += amount;
  }

  int getProgress() {
    return progress;
  }
}

// lib/models.dart
class Challenge {
  final String description;
  final int rewardXP;

  Challenge({required this.description, required this.rewardXP});
}

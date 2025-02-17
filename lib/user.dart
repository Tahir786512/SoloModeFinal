class User {
  int xp;
  int level;
  String title;

  User({required this.xp, required this.level, required this.title});

  void addXP(int amount) {
    xp += amount;
    while (xp >= getNextLevelXP()) {
      xp -= getNextLevelXP();
      level++;
      updateTitle();
    }
  }

  int getNextLevelXP() {
    if (level <= 100) {
      return 100 + (level - 1) * 20; // Example XP increment per level
    }
    if (level <= 300) return 300 + (level - 100) * 40;
    if (level <= 600) return 600 + (level - 300) * 60;
    return 1000 + (level - 600) * 80;
  }

  void updateTitle() {
    if (level <= 100 && level % 5 == 0) {
      title = "Hunter L$level"; // Change based on the *Solo Leveling* theme
    } else if (level <= 300 && level % 10 == 0)
      title = "S-Class Hunter L$level";
    else if (level <= 600 && level % 30 == 0)
      title = "Arch-Hunter L$level";
    else if (level <= 1000 && level % 50 == 0)
      title = "King of Hunters L$level";
  }

  void saveUserData() {}
}

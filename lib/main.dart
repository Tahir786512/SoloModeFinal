import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    User user = User(xp: 0, level: 1, title: "Beginner");

    return MaterialApp(
      title: 'Solo Leveling Fitness',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.cyanAccent,
        ),
      ),
      home: MainScreen(user: user),
    );
  }
}

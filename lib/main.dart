import 'package:flutter/material.dart';
import 'package:notesapp/features/AddnotesScreen.dart';
import 'package:notesapp/features/ChangepasswordScreen.dart';
import 'package:notesapp/features/DashboardScreen.dart';
import 'package:notesapp/features/LoginScreen.dart';
import 'package:notesapp/features/SignupScreen.dart';
import 'package:notesapp/features/SplashScreen.dart';
import 'package:notesapp/features/WelcomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "NotesApp",
      home: SplashScreen(),
    );
  }
}

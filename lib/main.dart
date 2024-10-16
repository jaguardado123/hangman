import 'package:flutter/material.dart';
import 'package:hangman_game/screens/mainscreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //pass down whether we are in an integration test or not
      home: const MainScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hangman_game/models/hangmangame.dart';
import 'package:hangman_game/config/globals.dart';

import 'gamescreen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Hangman",
              style: TextStyle(
                fontSize: 50,
              ),
            ),
            const Text(
              "Game",
              style: TextStyle(
                fontSize: 50,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
            ),
            const SizedBox(
                height: 100,
                child: Image(image: AssetImage('assets/progress_8.png'))),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            ),
            ElevatedButton(
              //Here we are giving the new game button a key for use in our integration tests in test_driver/app_test.dart
              key: const Key('new-game-button'),
              child: const Text("New Game",
                  style: TextStyle(fontSize: 25),
                  //Here we are giving the new game text field a key for use in our integration tests in test_driver/app_test.dart
                  key: Key('new-game-text')),
              onPressed: () async {
                String word =
                    await HangmanGame.getStartingWord(areWeInIntegrationTest);

                HangmanGame game = HangmanGame(word);

                //TODO: Push a GameScreen and give it the HangmanGame
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GameScreen(game: game)));
              },
            )
          ],
        ),
      ),
    );
  }
}

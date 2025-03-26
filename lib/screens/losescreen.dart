import 'package:flutter/material.dart';
import 'package:hangman_game/config/globals.dart';
import 'package:hangman_game/models/hangmangame.dart';

import 'gamescreen.dart';

class LoseScreen extends StatelessWidget {
  late HangmanGame game;
  //This should be modified to take in a HangmanGame
  LoseScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Here we are giving the lose game button a key for use in our integration tests in test_driver/app_test.dart
            const Text("You Lose",
                style: TextStyle(fontSize: 50), key: Key('lose-game-text')),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
            ),
            const SizedBox(
                height: 300,
                child: Image(image: AssetImage('assets/progress_7.png'))),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            ),
            Text('Your word was: ${game.word()}',
                style: const TextStyle(fontSize: 25)),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
            ),
            ElevatedButton(
                //Here we are giving the new game button a key for use in our integration tests in test_driver/app_test.dart
                key: const Key('new-game-btn'),
                child: const Text("New Game", style: TextStyle(fontSize: 25)),
                onPressed: () async {
                  //This setups a new game
                  String word =
                      await HangmanGame.getStartingWord(areWeInIntegrationTest);
                  HangmanGame game = HangmanGame(word);

                  //TODO: Push a GameScreen and give it the HangmanGame
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GameScreen(game: game)));
                })
          ],
        ),
      ),
    ));
  }
}

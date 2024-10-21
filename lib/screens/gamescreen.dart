import 'package:flutter/material.dart';
import 'package:hangman_game/models/hangmangame.dart';

import 'losescreen.dart';
import 'winscreen.dart';

class GameScreen extends StatefulWidget {
  final HangmanGame game;
  //This should be modified to take in a HangmanGame
  const GameScreen({Key? key, required this.game}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  //This will be the controller we use to take in what the user will be guessing
  final guessTextController = TextEditingController();

  //These two variables will be used if there is an issue with the letter the user attempts to guess
  bool showError = false;
  String guessTextFieldErrorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Center(
            child: ListView(
              children: <Widget>[
                const Padding(
                    padding: EdgeInsets.fromLTRB(0, 13, 0, 13),
                    child: Center(
                        child:
                            Text("Hangman", style: TextStyle(fontSize: 50)))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(widget.game.blanksWithCorrectGuesses(),

                        //Here we are giving the current progress towards completing the word a key for use in our integration tests in test_driver/app_test.dart
                        key: const Key('word-progress'),
                        style: const TextStyle(
                          fontSize: 40,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
                  child: Text('Wrong Guesses: ${widget.game.wrongGuesses()}',

                      //Here we are giving the list of wrong guesses a key for use in our integration tests in test_driver/app_test.dart
                      key: const Key('wrong-guesses'),
                      style: const TextStyle(fontSize: 17)),
                ),
                Row(
                  children: <Widget>[
                    ElevatedButton(
                        //Here we are giving the guessing button a key for use in our integration tests in test_driver/app_test.dart
                        key: const Key('guess-letter-btn'),
                        child:
                            //Here we are giving the letter the user guesses a key for use in our integration tests in test_driver/app_test.dart
                            const Text('Guess Letter',
                                style: TextStyle(fontSize: 16),
                                key: Key('guess-letter-text')),
                        onPressed: () {
                          setState(() {
                            //Get the string that the user typed in the box
                            String letter = guessTextController.text;

                            try {
                              // TODO: Calling the guess function on the game and passing it 'userGuess'

                              // TODO: Uncomment the following lines and get them to work. Follow the order of the tests, not the order that the TODOs they appear in the code.
                              // if( its a repeat ){
                              // showError = true;
                              // guessTextFieldErrorMessage =
                              //     'already used that letter';
                              // }else{
                              //   showError = false;
                              // }

                              // TODO: Reset the text in the textbox after a guess

                              // TODO: Check if the user has won the game, if they did navigate them to the win screen

                              // TODO: Check if the user has lost the game, if they did navigate them to the lose screen. You will need to pass the game to the LoseScreen.

                            } catch (e) {
                              //If the user is guessing an invalid character return this message
                              guessTextFieldErrorMessage = 'invalid';
                              showError = true;
                            }
                          });
                        }),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                        child: TextField(
                          //Here we are giving the guessing text field a key for use in our integration tests in test_driver/app_test.dart
                          key: const Key('guess-textfield'),
                          controller: guessTextController,
                          decoration: InputDecoration(
                            labelText: 'Enter New Letter',
                            errorText:
                                showError ? guessTextFieldErrorMessage : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

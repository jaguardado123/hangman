# Hangman Game

A Hangman Flutter app with unit, widget, and integration tests.



# HangmanGame Class

It handles the game logic

```dart
    // pass in the secret word
    var game = HangmanGame('banana');

    bool wasAbleToMakeGuess = game.guess('b');
    print(game.blanksWithCorrectGuesses) // b-----
    print(game.status) //returns win, lose, or play
    
```



# HangmanGame Class Unit Test

to run unit test do

```console
flutter test test/hangmangame_test.dart
```

Or in VS Code

1. Open the test/hangmangame_test.dart file
2. While in the test/hangmangame_test.dart file
3. Select the Debug menu
4. Click the Run Without Debuging option



## Overview of unit tests

### Making a new game
* tests word is initialized
* tests correctGuesses is empty at first
* tests wrongGuesses is empty at first



### Guessing Behavior (function guess(String letter))

* tests if user guess is not a letter an ArgumentError is thrown
* tests if user guess is correct it's added correctGuesses
* tests if user guess is incorrect it's added wrongGuesses
* tests guess function return true if user guess was accepted (note: does not return if guess was correct or wrong just if it was accepted)
* tests guess function returns false for duplicate letter guess
* tests that guess function is case insensitive



### Displaying Current Word Progress

```dart
    var game = HangmanGame('banana');

    print(game.blanksWithCorrectGuesses) // ------

    game.guess('b');
    game.guess('n');

    print(game.blanksWithCorrectGuesses) // b-n-n-
```
* tests that at first all letters are '-' for 
* tests that when a  guess is made blanksWithCorrectGuesses is updated properly



### Game Status

```dart
    var game = HangmanGame('car');

    print(game.status) // play

    game.guess('c');
    game.guess('a')
    game.guess('r');

    print(game.status) // win
```
* test status is update to win when user guesses all letters
* test status is update to lose after 7 incorrect guesses
* test status is play otherwise



# Widget Tests

We use unit test to test our pure classes, functions etc. and logic but now to test Widget we use Flutter's Test Widget package it work in the same manner as unit tests but provide tools to interact with Widgets 
like tapping buttons, finding text, entering text, searching the widget tree.

```console
flutter test test/widget_test.dart
```

Or in VS Code

1. Open the test/widget_test.dart file
2. While in the test/widget_test.dart file
3. Select the Debug menu
4. Click the Run Without Debuging option



# Integration Tests

Unit tests and widget tests are handy for testing individual classes, functions, or widgets. While Integration Test test applications as a whole running on a device. It tests UI as well as the flow between screens.

To run the Integration Test you will need a device connected or a simulator running.

Use the following command to run the integration tests

```console
flutter drive --target=test_driver/app.dart
```



## Overview of integration tests

At a highlevel the integration test works like how a user would interact with the app.

It makes sure the user can go from the Main Screen to the Game Screen and play the game. We know the game logic works because of our unit test now we need to test that the UI shows this interactions as the user plays and tries diffrent cases. The integration test runs various cases like inputting correct, wrong, duplicate, invalid guesses. As well as testing the flow from the Game Page to Winning or Losing Page.






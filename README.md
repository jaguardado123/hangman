# Hangman Game

A Hangman Flutter app with unit and integration tests.



# HangmanGame Class

It handles the game logic

```dart
    // pass in the secret word
    var game = HangmanGame('banana');

    bool wasAbleToMakeGuess = game.guess('b');
    print(game.blanksWithCorrectGuesses) // b-----
    print(game.status) //returns win, lose, or play
    
```



# HangmanGame Unit Tests

to run unit test do

```console
flutter test test/unit_test.dart
```

### In VS Code

1. Open the test/unit_test.dart file
2. While in the test/unit_test.dart file
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



# Integration Tests

Unit tests and widget tests are handy for testing individual classes, functions, or widgets. While Integration Test test applications as a whole running on a device. It tests UI as well as the flow between screens.

Use the following command to run the integration tests

### Run integration test in Codespace

```console
flutter test test/integration_test.dart
```

### Run integration test locally

```console
flutter test integration_test/integration_test.dart
```


## Overview of integration tests

At a highlevel the integration test works like how a user would interact with the app.

It makes sure the user can go from the Main Screen to the Game Screen and play the game. We know the game logic works because of our unit test now we need to test that the UI shows this interactions as the user plays and tries diffrent cases. The integration test runs various cases like inputting correct, wrong, duplicate, invalid guesses. As well as testing the flow from the Game Page to Winning or Losing Page.






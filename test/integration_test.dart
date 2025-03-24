import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hangman_game/main.dart';
import 'package:hangman_game/config/globals.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  areWeInIntegrationTest = true;

  testWidgets(
      'We should be at the home screen at launch and have the ability to start a new game',
      (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());

    //Here we assign variables using the type of our widgets and text in our screens folder so we can use them in this test
    final newGameBtnFinder = find.text("New Game");

    //We are expecting for the text found in the button on the home screen to say 'New Game'
    expect(find.text("New Game"), findsOneWidget);

    // Next we tap the button and are expecting to be navigated to a new screen where our guessing text field will be
    await tester.tap(newGameBtnFinder);
    await tester.pumpAndSettle();

    expect(find.text("Guess Letter"), findsOneWidget);
  });

  testWidgets(
      'Once we are at our game screen, we should be able to guess the letter b and the game should register it as one correct letter',
      (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());
    // Next we tap the button and are expecting to be navigated to a new screen where our guessing text field will be
    await tester.tap(find.text("New Game"));
    await tester.pumpAndSettle();

    //Here we assign variables using the type of our widgets and text in our screens folder so we can use them in this test
    final findGuessingTextField = find.byType(TextField);
    final guessLetterBtnFinder = find.text("Guess Letter");

    //Since we just started a new game, we expect to have no progress toward the completion of the game
    expect(find.text('------'), findsOneWidget);

    //Here we are going to guess our first letter b
    await tester.enterText(findGuessingTextField, 'b');
    await tester.tap(guessLetterBtnFinder);
    await tester.pumpAndSettle();

    //We expect for the game to now have registered that we have correctly guessed the first letter of the word banana that we instantiated it with
    expect(find.text('b-----'), findsOneWidget);
  });

  testWidgets(
      'After guessing the letter n, we are expecting the game to continue registering it as a correct guess and updating our progress',
      (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());
    // Next we tap the button and are expecting to be navigated to a new screen where our guessing text field will be
    await tester.tap(find.text("New Game"));
    await tester.pumpAndSettle();

    //Here we assign variables using the type of our widgets and text in our screens folder so we can use them in this test
    final findGuessingTextField = find.byType(TextField);
    final guessLetterBtnFinder = find.text("Guess Letter");

    //Here we are going to guess our first letter b
    await tester.enterText(findGuessingTextField, 'b');
    await tester.tap(guessLetterBtnFinder);
    await tester.pumpAndSettle();

    //Here we are guessing the letter n
    await tester.enterText(findGuessingTextField, 'n');
    await tester.tap(guessLetterBtnFinder);
    await tester.pumpAndSettle();

    //We expect the game to register our guess of the letter n as correct and update our progress
    expect(find.text('b-n-n-'), findsOneWidget);
  });

  testWidgets(
      'Guess an incorrect letter z, and expect for it to be added to our incorrect guesses list',
      (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());
    // Next we tap the button and are expecting to be navigated to a new screen where our guessing text field will be
    await tester.tap(find.text("New Game"));
    await tester.pumpAndSettle();

    //Here we assign variables using the type of our widgets and text in our screens folder so we can use them in this test
    final findGuessingTextField = find.byType(TextField);
    final guessLetterBtnFinder = find.text("Guess Letter");

    //Here we are going to guess our first letter b
    await tester.enterText(findGuessingTextField, 'b');
    await tester.tap(guessLetterBtnFinder);
    await tester.pumpAndSettle();

    //Here we are guessing the letter n
    await tester.enterText(findGuessingTextField, 'n');
    await tester.tap(guessLetterBtnFinder);
    await tester.pumpAndSettle();

    //Here we are going to intentionally guess z incorrectly to check if the game registers it as incorrect
    await tester.enterText(findGuessingTextField, 'z');
    await tester.tap(guessLetterBtnFinder);
    await tester.pumpAndSettle();

    //Our progress toward completion should not have changed with an incorrect guess
    expect(find.text('b-n-n-'), findsOneWidget);

    //We expect to see that our incorrect guess has been added to the list of incorrect guesses
    expect(find.text('Wrong Guesses: z'), findsOneWidget);
  });

  testWidgets(
      'Once I have guessed all correct letters of a word, the game should be over and I should be navigated to the Win Screen',
      (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());
    // Next we tap the button and are expecting to be navigated to a new screen where our guessing text field will be
    await tester.tap(find.text("New Game"));
    await tester.pumpAndSettle();

    //Here we assign variables using the type of our widgets and text in our screens folder so we can use them in this test
    final findGuessingTextField = find.byType(TextField);
    final guessLetterBtnFinder = find.text("Guess Letter");

    //Here we are going to guess correct letters to win the game.
    List<String> correctGuesses = ['b', 'n', 'a'];
    for (int i = 0; i < correctGuesses.length; i++) {
      await tester.enterText(findGuessingTextField, correctGuesses[i]);
      await tester.tap(guessLetterBtnFinder);
      await tester.pumpAndSettle();
    }

    //If we are successfully renavigated to the win screen we can expect to see this text
    expect(find.text('You Win'), findsOneWidget);
  });

  testWidgets('After winning the game, we should be able to start a new one',
      (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());
    // Next we tap the button and are expecting to be navigated to a new screen where our guessing text field will be
    await tester.tap(find.text("New Game"));
    await tester.pumpAndSettle();

    //Here we assign variables using the type of our widgets and text in our screens folder so we can use them in this test
    final findGuessingTextField = find.byType(TextField);
    final guessLetterBtnFinder = find.text("Guess Letter");

    //Here we are going to guess correct letters to win the game.
    List<String> correctGuesses = ['b', 'n', 'a'];
    for (int i = 0; i < correctGuesses.length; i++) {
      await tester.enterText(findGuessingTextField, correctGuesses[i]);
      await tester.tap(guessLetterBtnFinder);
      await tester.pumpAndSettle();
    }

    //If successfully navigated back to the game screen we should find our guessing field
    await tester.tap(find.text("New Game"));
    await tester.pumpAndSettle();
    expect(find.text("Guess Letter"), findsOneWidget);
  });

  testWidgets(
      'We should lose the game by incorrectly guessing 7 times in a row',
      (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());
    // Next we tap the button and are expecting to be navigated to a new screen where our guessing text field will be
    await tester.tap(find.text("New Game"));
    await tester.pumpAndSettle();

    //Here we assign variables using the type of our widgets and text in our screens folder so we can use them in this test
    final findGuessingTextField = find.byType(TextField);
    final guessLetterBtnFinder = find.text("Guess Letter");

    //We will be using a loop to incorrectly guess this list by iterating through it and guessing each time
    List<String> wrongGuesses = ['q', 'w', 'e', 'r', 't', 'y', 'u'];
    for (int i = 0; i < wrongGuesses.length; i++) {
      await tester.enterText(findGuessingTextField, wrongGuesses[i]);
      await tester.tap(guessLetterBtnFinder);
      await tester.pumpAndSettle();
    }

    //After incorrectly guessing 7 times, we expect to be renavigated to the Lose Screen
    expect(find.text('You Lose'), findsOneWidget);
  });

  testWidgets('After losing a game, we should be able to start a new one',
      (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());
    // Next we tap the button and are expecting to be navigated to a new screen where our guessing text field will be
    await tester.tap(find.text("New Game"));
    await tester.pumpAndSettle();

    //Here we assign variables using the type of our widgets and text in our screens folder so we can use them in this test
    final findGuessingTextField = find.byType(TextField);
    final guessLetterBtnFinder = find.text("Guess Letter");

    //We will be using a loop to incorrectly guess this list by iterating through it and guessing each time
    List<String> wrongGuesses = ['q', 'w', 'e', 'r', 't', 'y', 'u'];
    for (int i = 0; i < wrongGuesses.length; i++) {
      await tester.enterText(findGuessingTextField, wrongGuesses[i]);
      await tester.tap(guessLetterBtnFinder);
      await tester.pumpAndSettle();
    }

    //If successfully navigated back to the game screen from lose screen, we should find our guessing field
    await tester.tap(find.text("New Game"));
    await tester.pumpAndSettle();
    expect(find.text("Guess Letter"), findsOneWidget);
  });

  testWidgets('Guessing the same correct letter should return an error message',
      (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());
    // Next we tap the button and are expecting to be navigated to a new screen where our guessing text field will be
    await tester.tap(find.text("New Game"));
    await tester.pumpAndSettle();

    //Here we assign variables using the type of our widgets and text in our screens folder so we can use them in this test
    final findGuessingTextField = find.byType(TextField);
    final guessLetterBtnFinder = find.text("Guess Letter");

    //Here we are going to guess correct letter b twice
    await tester.enterText(findGuessingTextField, 'b');
    await tester.tap(guessLetterBtnFinder);
    await tester.pumpAndSettle();
    await tester.enterText(findGuessingTextField, 'b');
    await tester.tap(guessLetterBtnFinder);
    await tester.pumpAndSettle();

    //Expect to get this error message back from the game
    expect(find.text("already used that letter"), findsOneWidget);
  });

  testWidgets(
      'Guessing the same incorrect letter should return an error message',
      (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());
    // Next we tap the button and are expecting to be navigated to a new screen where our guessing text field will be
    await tester.tap(find.text("New Game"));
    await tester.pumpAndSettle();

    //Here we assign variables using the type of our widgets and text in our screens folder so we can use them in this test
    final findGuessingTextField = find.byType(TextField);
    final guessLetterBtnFinder = find.text("Guess Letter");

    //Here we are going to guess wrong letter q twice
    await tester.enterText(findGuessingTextField, 'q');
    await tester.tap(guessLetterBtnFinder);
    await tester.pumpAndSettle();
    await tester.enterText(findGuessingTextField, 'q');
    await tester.tap(guessLetterBtnFinder);
    await tester.pumpAndSettle();

    //Expect to get this error message back from the game
    expect(find.text("already used that letter"), findsOneWidget);
  });

  testWidgets(
      'When guessing an character that is not alphanumeric, we expect an invalid message from the game',
      (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());
    // Next we tap the button and are expecting to be navigated to a new screen where our guessing text field will be
    await tester.tap(find.text("New Game"));
    await tester.pumpAndSettle();

    //Here we assign variables using the type of our widgets and text in our screens folder so we can use them in this test
    final findGuessingTextField = find.byType(TextField);
    final guessLetterBtnFinder = find.text("Guess Letter");

    //Here we are going to guess invalid character @
    await tester.enterText(findGuessingTextField, '@');
    await tester.tap(guessLetterBtnFinder);
    await tester.pumpAndSettle();

    // Expect to get invalid message from the game.
    expect(find.text("invalid"), findsOneWidget);
  });

  testWidgets(
      'When guessing a string that contains multiple letters, we expect an invalid message from the game',
      (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());
    // Next we tap the button and are expecting to be navigated to a new screen where our guessing text field will be
    await tester.tap(find.text("New Game"));
    await tester.pumpAndSettle();

    //Here we assign variables using the type of our widgets and text in our screens folder so we can use them in this test
    final findGuessingTextField = find.byType(TextField);
    final guessLetterBtnFinder = find.text("Guess Letter");

    //Here we are going to guess multiple letters at once.
    await tester.enterText(findGuessingTextField, 'ab');
    await tester.tap(guessLetterBtnFinder);
    await tester.pumpAndSettle();

    // Expect to get invalid message from the game.
    expect(find.text("invalid"), findsOneWidget);
  });
}

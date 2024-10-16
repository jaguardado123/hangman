// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  late FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    driver.close();
  });

  test(
      'We should be at the home screen at launch and have the ability to start a new game',
      () async {
    //Here we assign variables using the keys we have placed on our widgets in our screens folder so we can use them in this test
    final newGameBtnFinder = find.byValueKey('new-game-button');
    final newGameTextFinder = find.byValueKey('new-game-text');

    //We are expecting for the text found in the button on the home screen to say 'New Game'
    expect(await driver.getText(newGameTextFinder), "New Game");

    // Next we tap the button and are expecting to be navigated to a new screen where our guessing text field will be
    await driver.tap(newGameBtnFinder);

    //Assignment of variable with the key of our guessing text field
    final guessLetterTextFinder = find.byValueKey('guess-letter-text');

    expect(await driver.getText(guessLetterTextFinder), "Guess Letter");
  }, skip: true);

  test(
      'Once we are at our game screen, we should be able to guess the letter b and the game should register it as one correct letter',
      () async {
    //Here we assign variables using the keys we have placed on our widgets in our screens folder so we can use them in this test
    final findGuessingTextField = find.byValueKey('guess-textfield');
    final guessLetterBtnFinder = find.byValueKey('guess-letter-btn');
    final findLettersLeftProgressField = find.byValueKey('word-progress');

    //Since we just started a new game, we expect to have no progress toward the completion of the game
    expect(await driver.getText(findLettersLeftProgressField), '------');

    //Here we are going to guess our first letter b
    await driver.tap(findGuessingTextField);
    await driver.enterText('b');
    await driver.waitFor(find.text('b'));

    await driver.tap(guessLetterBtnFinder);

    //We expect for the game to now have registered that we have correctly guessed the first letter of the word banana that we instantiated it with
    expect(await driver.getText(findLettersLeftProgressField), 'b-----');
  }, skip: true);

  test(
      'After guessing the letter n, we are expecting the game to continue registering it as a correct guess and updating our progress',
      () async {
    //Here we assign variables using the keys we have placed on our widgets in our screens folder so we can use them in this test
    final findGuessingTextField = find.byValueKey('guess-textfield');
    final guessLetterBtnFinder = find.byValueKey('guess-letter-btn');
    final findLettersLeftProgressField = find.byValueKey('word-progress');

    //Here we are guessing the letter n
    await driver.tap(findGuessingTextField);
    await driver.enterText('n');
    await driver.waitFor(find.text('n'));

    await driver.tap(guessLetterBtnFinder);

    //We expect the game to register our guess of the letter n as correct and update our progress
    expect(await driver.getText(findLettersLeftProgressField), 'b-n-n-');
  }, skip: true);

  test(
      'Guess an incorrect letter z, and expect for it to be added to our incorrect guesses list',
      () async {
    //Here we assign variables using the keys we have placed on our widgets in our screens folder so we can use them in this test
    final findGuessingTextField = find.byValueKey('guess-textfield');
    final guessLetterBtnFinder = find.byValueKey('guess-letter-btn');
    final findLettersLeftProgressField = find.byValueKey('word-progress');
    final findWrongGuessesField = find.byValueKey('wrong-guesses');
    //Here we are going to intentionally guess z incorrectly to check if the game registers it as incorrect
    await driver.tap(findGuessingTextField);
    await driver.enterText('z');
    await driver.waitFor(find.text('z'));

    await driver.tap(guessLetterBtnFinder);

    //Our progress toward completion should not have changed with an incorrect guess
    expect(await driver.getText(findLettersLeftProgressField), 'b-n-n-');

    //We expect to see that our incorrect guess has been added to the list of incorrect guesses
    expect(await driver.getText(findWrongGuessesField), 'Wrong Guesses: z');
  }, skip: true);

  test(
      'Once I have guessed all correct letters of a word, the game should be over and I should be navigated to the Win Screen',
      () async {
    //Here we assign variables using the keys we have placed on our widgets in our screens folder so we can use them in this test
    final findGuessingTextField = find.byValueKey('guess-textfield');
    final guessLetterBtnFinder = find.byValueKey('guess-letter-btn');
    final findWinText = find.byValueKey('win-game-text');

    //Here we will be guessing the last remaining letter 'a' to finish winning the game
    await driver.tap(findGuessingTextField);
    await driver.enterText('a');
    await driver.waitFor(find.text('a'));

    await driver.tap(guessLetterBtnFinder);

    //If we are successfully renavigated to the win screen we can expect to see this text
    expect(await driver.getText(findWinText), 'You Win');
  }, skip: true);

  test('After winning the game, we should be able to start a new one',
      () async {
    //Here we assign variables using the keys we have placed on our widgets in our screens folder so we can use them in this test
    final newGameBtn = find.byValueKey('new-game-btn');
    final guessLetterTextFinder = find.byValueKey('guess-letter-text');

    //Start a new game from the Win Screen by tapping the button
    await driver.tap(newGameBtn);

    //If successfully navigated back to the game screen we should find our guessing field
    expect(await driver.getText(guessLetterTextFinder), "Guess Letter");
  }, skip: true);

  test('We should lose the game by incorrectly guessing 7 times in a row',
      () async {
    //Here we assign variables using the keys we have placed on our widgets in our screens folder so we can use them in this test
    final findGuessingTextField = find.byValueKey('guess-textfield');
    final guessLetterBtnFinder = find.byValueKey('guess-letter-btn');
    final findLoseText = find.byValueKey('lose-game-text');

    //We will be using a loop to incorrectly guess this list by iterating through it and guessing each time
    List<String> wrongGuesses = ['q', 'w', 'e', 'r', 't', 'y', 'u'];
    for (int i = 0; i < wrongGuesses.length; i++) {
      await driver.tap(findGuessingTextField);
      await driver.enterText(wrongGuesses[i]);
      await driver.waitFor(find.text(wrongGuesses[i]));

      await driver.tap(guessLetterBtnFinder);
    }

    //After incorrectly guessing 7 times, we expect to be renavigated to the Lose Screen
    expect(await driver.getText(findLoseText), 'You Lose');
  }, skip: true);

  test('After losing a game, we should be able to start a new one', () async {
    //Here we assign variables using the keys we have placed on our widgets in our screens folder so we can use them in this test
    final newGameBtn = find.byValueKey('new-game-btn');
    final guessLetterTextFinder = find.byValueKey('guess-letter-text');

    //After tapping the new game button on the Lose Screen, we should be renavigated to the game screen
    await driver.tap(newGameBtn);
    expect(await driver.getText(guessLetterTextFinder), "Guess Letter");
  }, skip: true);

  test('Guessing the same correct letter should return an error message',
      () async {
    //Here we assign variables using the keys we have placed on our widgets in our screens folder so we can use them in this test
    final findGuessingTextField = find.byValueKey('guess-textfield');
    final guessLetterBtnFinder = find.byValueKey('guess-letter-btn');
    String correctLetter = 'b';

    //Guess b as the first letter
    await driver.tap(findGuessingTextField);
    await driver.enterText(correctLetter);
    await driver.waitFor(find.text(correctLetter));

    await driver.tap(guessLetterBtnFinder);

    //Try guessing the same letter again
    await driver.tap(findGuessingTextField);
    await driver.enterText(correctLetter);
    await driver.waitFor(find.text(correctLetter));

    await driver.tap(guessLetterBtnFinder);

    //Expect to get this error message back from the game
    await driver.waitFor(find.text("already used that letter"));
  }, skip: true);

  test('Guessing the same incorrect letter should return an error message',
      () async {
    //Here we assign variables using the keys we have placed on our widgets in our screens folder so we can use them in this test
    final findGuessingTextField = find.byValueKey('guess-textfield');
    final guessLetterBtnFinder = find.byValueKey('guess-letter-btn');
    String wrongLetter = 'q';

    //Guess q as the first incorrect letter
    await driver.tap(findGuessingTextField);
    await driver.enterText(wrongLetter);
    await driver.waitFor(find.text(wrongLetter));
    await driver.tap(guessLetterBtnFinder);

    //Guess same letter again
    await driver.tap(findGuessingTextField);
    await driver.enterText(wrongLetter);
    await driver.waitFor(find.text(wrongLetter));
    await driver.tap(guessLetterBtnFinder);

    //Expect to get this error message back from the game
    await driver.waitFor(find.text("already used that letter"));
  }, skip: true);

  test(
      'When guessing an character that is not alphanumeric, we expect an invalid message from the game',
      () async {
    //Here we assign variables using the keys we have placed on our widgets in our screens folder so we can use them in this test
    final findGuessingTextField = find.byValueKey('guess-textfield');
    final guessLetterBtnFinder = find.byValueKey('guess-letter-btn');
    String invalidCharacter = '@';

    //Guess invalid character and expect to receive an invalid message back
    await driver.tap(findGuessingTextField);
    await driver.enterText(invalidCharacter);
    await driver.tap(guessLetterBtnFinder);
    await driver.waitFor(find.text("invalid"));
  }, skip: true);

  test(
      'When guessing a string that contains multiple letters, we expect an invalid message from the game',
      () async {
    //Here we assign variables using the keys we have placed on our widgets in our screens folder so we can use them in this test
    final findGuessingTextField = find.byValueKey('guess-textfield');
    final guessLetterBtnFinder = find.byValueKey('guess-letter-btn');
    String invalidCharacter = 'ab';

    //Guess invalid character and expect to receive an invalid message back
    await driver.tap(findGuessingTextField);
    await driver.enterText(invalidCharacter);
    await driver.tap(guessLetterBtnFinder);
    await driver.waitFor(find.text("invalid"));
  }, skip: true);
}
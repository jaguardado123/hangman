import 'package:http/http.dart' as http;

class HangmanGame {
  String _word = "";
  String _correctGuesses = "";
  String _wrongGuesses = "";
  int _guesses = 0;

  //Constructor starts off with blank strings that we will concatenate during the course of play
  HangmanGame(String word) {
    _word = word;
    _correctGuesses = "";
    _wrongGuesses = "";
  }

  String correctGuesses() {
    return _correctGuesses;
  }

  String wrongGuesses() {
    return _wrongGuesses;
  }

  String word() {
    return _word;
  }

  bool guess(String letter) {
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(letter) || letter.length > 1) {
      throw new ArgumentError();
    }
    letter = letter.toLowerCase();
    // TODO: Fill this in
    if (_word.contains(letter) && !_correctGuesses.contains(letter)) {
      _correctGuesses += letter;
      _guesses++;
      return true;
    } else if (!_word.contains(letter) && !_wrongGuesses.contains(letter)) {
      _wrongGuesses += letter;
      _guesses++;
      return true;
    } else {
      return false;
    }
  }

  String blanksWithCorrectGuesses() {
    // TODO: Fill this in
    String cblanks = "";
    for (int i = 1; i <= _word.length; i++) {
      if (_correctGuesses.contains(_word.substring(i - 1, i))) {
        cblanks += _word.substring(i - 1, i);
      } else {
        cblanks += "-";
      }
    }
    return cblanks;
  }

  String status() {
    // TODO: Fill this in
    if (blanksWithCorrectGuesses() == _word)
      return "win";
    else if (_guesses >= 7) return "lose";
    return "play";
  }

  //when running integration tests always return "banana"
  static Future<String> getStartingWord(bool areWeInIntegrationTest) async {
    String word;
    final Uri endpoint =
        Uri.parse("http://randomword.saasbook.info/RandomWord");
    if (areWeInIntegrationTest) {
      word = "banana";
    } else {
      try {
        final response = await http.post(endpoint);
        word = response.body;
      } catch (e) {
        word = "error";
      }
    }

    return word;
  }
}

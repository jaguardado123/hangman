import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class HangmanGame {
  String _word = "";
  String _correctGuesses = "";
  String _wrongGuesses = "";

  // Constructor starts off with blank strings that we will concatenate during the course of play.
  HangmanGame(String word) {
    _word = word;
    _correctGuesses = "";
    _wrongGuesses = "";
  }

  //
  // TODO: Complete the functions below to pass the Unit Tests.

  String correctGuesses() {
    return '';
  }

  String wrongGuesses() {
    return '';
  }

  String word() {
    return '';
  }

  bool guess(var letter) {
    return false;
  }

  String blanksWithCorrectGuesses() {
    return '';
  }

  String status() {
    return '';
  }

  // When running integration tests always return "banana".
  static Future<String> getStartingWord(bool areWeInIntegrationTest) async {
    String word;
    if (areWeInIntegrationTest) {
      word = "banana";
    } else {
      // If not an integration test, fetch a random word from API
      try {
        final response = await http.get(
          Uri.parse("https://randomword.saasbook.info/RandomWord"),
          headers: {'Accept': 'text/plain'},
        );
        final doc = parser.parse(response.body);
        word = doc.body?.text ?? '';
      } catch (e) {
        // Return "error" if API fetch fails
        word = "error";
      }
    }

    return word;
  }
}

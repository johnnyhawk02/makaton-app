import 'word.dart' show Word;
import 'functions.dart';

class Sentence {
  String _sentence;
  List<Word> word = [];
  Sentence(this._sentence) {
    //Word wd = new Word(this._sentence);
    this._sentence.split(' ').forEach(
      (String currentWord) {
        Word wd = new Word(currentWord);
        word.add(wd);
      },
    );
  }

  String toString() {
    String result = '';
    word.forEach(
      (w) {
        if (!w.isKeyword) result += '-';
        if (w.displayName == w.name) {
          result += w.displayName + ' ';
        } else {
          result += w.displayName + '(' + w.name + ')' + ' ';
        }
      },
    );
    return result.trimRight();
  }

  void printOut() {
    word.forEach(
      (w) {
        print('_____________________');
        print(
            '${w.displayName} ${(w.displayName == w.name) ? '' : '(' + w.name + ')'}');
        if (!w.isKeyword) print('not keyword');
        print('${w.imagePath}');
        print('_____________________');
        print('');
      },
    );
  }
}

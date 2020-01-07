import 'dart:math';

abstract class RandomPhrase {
  static wellDone() {
    List<String> phraseList = [
      'Well Done!',
      'Wow, excellent!',
      'Superb!!!',
      'Wicked Ace!',
      'Peppa would be proud of you!',
      'Wizard, like totally GREAT!',
    ];
    return phraseList[Random().nextInt(phraseList.length)];
  }

  static no() {
    List<String> phraseList = [
      'no',
      'wrong',
      'whoopsy daisy!!!',
      'no no no!',
      'incorrect',
      'negativ-a-tory',
      "that's not right",
      'naaaaah!',
      'nopey nope you dope!',
      'peppa pig says: NO!!!',
      'Elsa says: WRONG!!!',
      'come on! you can do this!!!',
    ];
    return phraseList[Random().nextInt(phraseList.length)];
  }
}

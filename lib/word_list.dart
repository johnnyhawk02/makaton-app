import 'imagePaths.dart' show imagePaths;
import 'dart:math' show Random;
import 'functions.dart';
import 'random_word_list.dart' show randomWordList;

abstract class WordList {
  static List<String> filteredList(String filter) {
    List<String> myList = List();

    imagePaths.forEach(
      (k, v) {
        if (k.startsWith(filter)) myList.add(k);
      },
    );

    return myList;
  }

  static List<String> randomList(int count) {
    Random rnd = new Random();
    List<String> myList = List();
    //List<String> wordList = imagePaths.keys.toList();

    for (int i = 0; i < count; i++) {
      myList.add(randomWordList[rnd.nextInt(randomWordList.length-1)]);
      //myList.add(randomWordList[rnd.nextInt(5)+3]);
    }

    return myList;
  }
}

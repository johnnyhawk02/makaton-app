import 'imagePaths.dart' show imagePaths;
import 'dart:math' show Random;
import 'functions.dart';
import 'random_word_list.dart' show randomWordList;

class NameAndPath {
  String name;
  String path;
  NameAndPath(this.name, this.path);
}

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

  static List<NameAndPath> randomList(int count) {
    Random rnd = new Random();
    List<NameAndPath> myList = List();
    //List<String> wordList = imagePaths.keys.toList();
    String name;
    String path;
    NameAndPath nameAndPath;
    for (int i = 0; i < count; i++) {
      //name = randomWordList[rnd.nextInt(randomWordList.length - 1)];
      name = randomWordList[(i*(randomWordList.length / count).round()) + rnd.nextInt((randomWordList.length / count).round())];

      path = imagePaths[name];
      name = underscoreToSpace(name);
      nameAndPath = NameAndPath(name, path);
      myList.add(nameAndPath);
    }
    return myList;
  }

  static List<String> randomList2(int count) {
    Random rnd = new Random();
    List<String> myList = List();
    //List<String> wordList = imagePaths.keys.toList();

    for (int i = 0; i < count; i++) {
      myList.add(randomWordList[rnd.nextInt(randomWordList.length - 1)]);
    }
    return myList;
  }
}

import 'word.dart' show Word;
import 'package:flutter/material.dart';
import 'functions.dart';

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}

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

  List<Item> users = <Item>[
    const Item('Android',Icon(Icons.android,color:  const Color(0xFF167F67),)),
    const Item('Flutter',Icon(Icons.flag,color:  const Color(0xFF167F67),)),
    const Item('ReactNative',Icon(Icons.format_indent_decrease,color:  const Color(0xFF167F67),)),
    const Item('iOS',Icon(Icons.mobile_screen_share,color:  const Color(0xFF167F67),)),
  ];

  List<String> toList() {
    List<String> result =[];
    word.forEach(
          (w) {
         result.add(w.displayName);


      },
    );
    return result;
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

  replace(int index, String s) {
    word[index].setName(s);
  }
}

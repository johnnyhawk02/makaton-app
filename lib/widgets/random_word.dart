import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import '../functions.dart';
import '../imagePaths.dart';
import '../random_phrase.dart';
import '../word_list.dart';



class RandomWord extends StatefulWidget {
  @override
  _RandomWordState createState() => _RandomWordState();
}

enum TtsState { playing, stopped }

class _RandomWordState extends State<RandomWord> {
  List<NameAndPath> randomWordList = WordList.randomList(4);
  FlutterTts flutterTts = FlutterTts();
  TtsState ttsState;
  int currentWordIndex;
  bool guessedRight = false;
  List<bool> indexesGuessed = [];
  static AudioCache player = new AudioCache();
  final soundApplause = "applause.mp3";
  final soundWrong = "wrong.mp3";

  Future _speak(phrase) async {
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
    var result = await flutterTts.speak(phrase);
    if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  void myGuess(index) {
    if (!guessedRight && indexesGuessed[index] == false ) {
      print('${index} - $currentWordIndex ');
      indexesGuessed[index] = true;
      if (index == currentWordIndex) {
        generateRandomImage();
      } else {
        player.play(soundWrong);
        this._speak(RandomPhrase.no());
      }
    }
  }

  void generateRandomImage() {
    setState(() {
      guessedRight = true;
    });

    player.play(soundApplause);
    String phrase;
    phrase = '${RandomPhrase.wellDone()}: ';
    phrase += '${randomWordList[currentWordIndex].name} is spelt: ';
    for (int i = 0; i < randomWordList[currentWordIndex].name.length; i++) {
      phrase += '${randomWordList[currentWordIndex].name[i]} ';
    }
    _speak(phrase);
    Future.delayed(
      const Duration(milliseconds: 4500),
      () {
        setState(
          () {
            guessedRight = false;
            for (int i = 0; i < 4; i++) {
              indexesGuessed[i] = false;
            }
            currentWordIndex = Random().nextInt(4);
            randomWordList = WordList.randomList(4);
          },
        );
      },
    );

    //this._speak(randomWordList[currentWordIndex]);
  }

  void speakCurrentWordWithHelp() {
    String phrase;
    phrase = randomWordList[currentWordIndex].name;
    phrase += ' begins with the letter: ';
    phrase += randomWordList[currentWordIndex].name[0];
    _speak(phrase);
  }

  @override
  void initState() {
    super.initState();
    currentWordIndex = Random().nextInt(4);
    randomWordList = WordList.randomList(4);
    for (int i = 0; i < 4; i++) {
      indexesGuessed.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 5000),
      curve: Curves.fastOutSlowIn,

//      decoration: BoxDecoration(
//        gradient: LinearGradient(
//          begin: Alignment.topCenter,
//          end: Alignment.bottomCenter,
//          colors: [Colors.blue, Colors.lightBlueAccent],
//        ),
//      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: speakCurrentWordWithHelp,
                      child: Image.asset(
                        'assets/images/symbols/' +
                            randomWordList[currentWordIndex].path,
                        fit: BoxFit.contain,
                        height: 150,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children:
                          List<Widget>.generate(randomWordList.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          child: RaisedButton(
                            elevation: (guessedRight&&currentWordIndex==index)?4:1,

                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            //color: Colors.red,

                            onPressed: () => myGuess(index),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: (Text(
                                randomWordList[index].name,
                                style: GoogleFonts.didactGothic(
                                  textStyle: TextStyle(
                                      color: (indexesGuessed[index]||guessedRight) &&
                                              !(index == currentWordIndex)
                                          ? Colors.grey[100]
                                          : Colors.black),
//                                  fontWeight: indexesGuessed[index] &&
//                                          (index == currentWordIndex)
//                                      ? FontWeight.bold
//                                      : FontWeight.normal,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 35,
                                ),
                              )),
                            ),
                          ),
                        );
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

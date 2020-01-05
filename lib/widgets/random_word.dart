import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import '../functions.dart';
import '../imagePaths.dart';
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
    if (!guessedRight) {
      print('${index} - $currentWordIndex ');
      indexesGuessed[index] = true;
      if (index == currentWordIndex) {
        generateRandomImage();
      } else {
        player.play(soundWrong);
        this._speak('no');
      }
    }
  }

  void generateRandomImage() {
    setState(() {
      guessedRight = true;
    });

    player.play(soundApplause);
    String phrase;
    phrase = 'well done it was: ${randomWordList[currentWordIndex].name}. ';
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
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: speakCurrentWordWithHelp,
                child: Image.asset(
                  'assets/images/symbols/' +
                      randomWordList[currentWordIndex].path,
                  fit: BoxFit.contain,
                  height: 250,
                ),
              ),
              Column(
                children: List<Widget>.generate(randomWordList.length, (index) {
                  return Card(
                    //color: indexesGuessed[index] ? Colors.red : Colors.white,
                    child: FlatButton(
                      onPressed: () => myGuess(index),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: (Text(
                          randomWordList[index].name,
                          style: GoogleFonts.didactGothic(
                            textStyle: TextStyle(
                                color: indexesGuessed[index] &&
                                        !(index == currentWordIndex)
                                    ? Colors.red
                                    : Colors.black),
                            fontWeight: indexesGuessed[index] &&
                                    (index == currentWordIndex)
                                ? FontWeight.bold
                                : FontWeight.normal,
                            //fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        )),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

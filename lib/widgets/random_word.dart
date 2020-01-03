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
  List<String> randomWordList =
      WordList.randomList(count: 4, removeUnderscores: true);
  FlutterTts flutterTts = FlutterTts();
  TtsState ttsState;
  int currentWordIndex;
  List<bool> indexesGuessed = [];
  static AudioCache player = new AudioCache();
  final soundApplause = "applause.mp3";


  Future _speak(phrase) async {
    var result = await flutterTts.speak(phrase);
    if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  bool myGuess(index) {
    print('${index} - $currentWordIndex ');
    indexesGuessed[index] = true;
    if (index == currentWordIndex) {
      player.play(soundApplause);
      generateRandomImage();
    } else {
      this._speak(''
          'wrong');
    }
  }

  void generateRandomImage() {
    Future.delayed(const Duration(milliseconds: 2000), () {

      setState(() {
        for (int i = 0; i < 4; i++) {
          indexesGuessed[i] = false;
        }
        currentWordIndex = Random().nextInt(4);
        randomWordList = WordList.randomList(count: 4, removeUnderscores: true);
      });
    });

    this._speak(randomWordList[currentWordIndex]);
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    currentWordIndex = Random().nextInt(4);
    randomWordList = WordList.randomList(count: 4, removeUnderscores: true);
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
              GestureDetector (
                onTap: ()=>_speak(randomWordList[currentWordIndex]),
                child:

              Image.asset(
                'assets/images/symbols/' +
                    //bug here need underscores
                    imagePaths[randomWordList[currentWordIndex]],

                fit: BoxFit.contain,
                height: 250,
                //colorBlendMode: BlendMode.srcOver ,
              ),
    ),
              Column(
                children: List<Widget>.generate(randomWordList.length, (index) {
                  return FlatButton(
                    onPressed: () => myGuess(index),
                    child: Card(
                      //color: indexesGuessed[index] ? Colors.red : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: (Text(
                          randomWordList[index],
                          style: GoogleFonts.didactGothic(
                            textStyle: TextStyle(color: indexesGuessed[index]?Colors.red:Colors.black),
                                  fontWeight: FontWeight.normal,
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

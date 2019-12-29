import 'package:webmakaton/sentence.dart';
import 'package:webmakaton/sentence.dart';
import '../imagePaths.dart' show imagePaths;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webmakaton/word_list.dart';
import 'package:webmakaton/imagePaths.dart';

//import 'package:flutter/foundation.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({
    Key key,
    @required Sentence sentence,  setTextEditingControllerText,
  })  : _sentence = sentence, _setTextEditingControllerText = setTextEditingControllerText,
        super(key: key);

  final Sentence _sentence;
  final _setTextEditingControllerText;

  @override
  Widget build(BuildContext context) {
    void _showDialog(sentenceIndex) {
      List myList = WordList.filteredList(_sentence.word[sentenceIndex].displayName);
      print (myList[0]);
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog

          return FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: AlertDialog(
              title: Text("${_sentence.word[sentenceIndex].displayName}"),
              content: SingleChildScrollView(
                child: Container(
                  height: 900,
                  child: Column(

                    children: List<Widget>.generate(myList.length, (index) {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            onTap: (){
                              _sentence.replace(sentenceIndex, myList[index]);
                              _setTextEditingControllerText(_sentence.toString());
                              },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  myList[index],
                                  style: GoogleFonts.didactGothic(
                                    fontWeight: FontWeight.normal,
                                    fontSize:
                                    20,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/images/symbols/' +
                                        imagePaths[myList[index]],


                                    height: 50,
                                   ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
              actions: <Widget>[
                 //usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ],
            ),
          );
        },
      );
    }

    return new GridView.count(
      childAspectRatio: 1.3,
      crossAxisCount: 3,
      children: List<Widget>.generate(_sentence.word.length, (index) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              onTap: () => _showDialog(index),
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/symbols/' +
                              _sentence.word[index].imagePath,

                          fit: BoxFit.contain,
                          height: MediaQuery.of(context).size.width * 0.1,
                          //colorBlendMode: BlendMode.srcOver ,
                        ),
//                      Image.asset(
//                        'assets/images/signs/' +
//                            _sentence.word[index].imagePath,
//
//                        fit: BoxFit.contain,
//                        height: MediaQuery.of(context).size.width * 0.2,
//                        //colorBlendMode: BlendMode.srcOver ,
//                      ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _sentence.word[index].displayName,
                            style: GoogleFonts.didactGothic(
                              fontWeight: FontWeight.normal,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

import 'package:webmakaton/sentence.dart';
//import '../imagePaths.dart' show imagePaths;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webmakaton/word_list.dart';
import 'package:webmakaton/imagePaths.dart';

//import 'package:flutter/foundation.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({
    Key key,
    @required Sentence sentence,
    setTextEditingControllerText,
  })  : _sentence = sentence,
        _setTextEditingControllerText = setTextEditingControllerText,
        super(key: key);

  final Sentence _sentence;
  final _setTextEditingControllerText;

  @override
  Widget build(BuildContext context) {
    void _showDialog(sentenceIndex) {
      String searchWord = _sentence.word[sentenceIndex].displayName;

      List myList = WordList.filteredList(searchWord.length == 0
          ? 'cxcxcx'
          : searchWord.substring(0, searchWord.length > 2? 3:searchWord.length));
      print(myList[0]);
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog

          return AlertDialog(
            title: Text("${_sentence.word[sentenceIndex].displayName}"),
            content: FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[

                    Container(
                      //height: 1900,
                      child: Column(
                        children: List<Widget>.generate(myList.length, (index) {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _sentence.replace(
                                      sentenceIndex, myList[index]);
                                  _setTextEditingControllerText(
                                      _sentence.toString());
                                  Navigator.of(context).pop();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      myList[index],
                                      style: GoogleFonts.didactGothic(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20,
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
                  ],
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
          );
        },
      );
    }

    return new Wrap(
      spacing: 1.0,
      runSpacing: 2.0,
      children: List<Widget>.generate(_sentence.word.length, (index) {
        return GestureDetector(
          onTap: () => _showDialog(index),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                           child: TextField(
                            keyboardType: TextInputType.text,

                            //controller: _textEditingController,
                            onChanged: (text) {
                              // _setTextFieldText(text);
                              // print("First text field: $text");
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: (){},// _clearTextField,

                                ),
                                hintText: 'Display Name'),
                          ),
                        ),

                        Flexible(
                           child: TextField(
                            keyboardType: TextInputType.text,

                            //controller: _textEditingController,
                            onChanged: (text) {
                              // _setTextFieldText(text);
                              // print("First text field: $text");
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: (){},// _clearTextField,

                                ),
                                hintText: 'Symbol Name'),
                          ),
                        ),
                      ],
                    ),

                    Image.asset(
                      'assets/images/symbols/' +
                          _sentence.word[index].imagePath,

                      fit: BoxFit.contain,
                      height: 30,
                      //colorBlendMode: BlendMode.srcOver ,
                    ),
//
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            _sentence.word[index].displayName ==
                                    _sentence.word[index].name
                                ? '${_sentence.word[index].name}'
                                : '${_sentence.word[index].displayName} (${_sentence.word[index].name})',
                            style: GoogleFonts.didactGothic(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                            ),
                          ),
                        ),
//                        _sentence.word[index].name ==
//                                _sentence.word[index].displayName
//                            ? Container()
//                            : Padding(
//                                padding: const EdgeInsets.all(3.0),
//                                child: Text(
//                                  '(${_sentence.word[index].name})',
//                                  style: GoogleFonts.didactGothic(
//                                    fontWeight: FontWeight.normal,
//                                    fontSize: 18,
//                                  ),
//                                ),
//                              ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

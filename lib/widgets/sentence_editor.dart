import 'package:webmakaton/sentence.dart';
//import '../imagePaths.dart' show imagePaths;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webmakaton/word_list.dart';
import 'package:webmakaton/imagePaths.dart';

//import 'package:flutter/foundation.dart';

class SentenceEditor extends StatefulWidget {
  const SentenceEditor({
    Key key,

    @required Sentence sentence,
    setTextEditingControllerText,
  })  : _sentence = sentence,
        _setTextEditingControllerText = setTextEditingControllerText,
        super(key: key);

  final Sentence _sentence;
  final _setTextEditingControllerText;

  @override
  _SentenceEditorState createState() => _SentenceEditorState();
}

class _SentenceEditorState extends State<SentenceEditor> {
  int currentWordIndex = 0;
  TextEditingController displayNameTextEditingController =
      TextEditingController();
  TextEditingController symbolTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: symbolTextEditingController,
                        onChanged: (text) {
                          setState(() {
                            widget._sentence.replace(currentWordIndex, text);
  widget._setTextEditingControllerText (widget._sentence.toString());
                          });
                           //widget._setTextFieldText(text);
                          // print("First text field: $text");
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {}, // _clearTextField,
                            ),
                            hintText: 'Symbol Name'),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: displayNameTextEditingController,
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
                              onPressed: () {}, // _clearTextField,
                            ),
                            hintText: 'Symbol Name'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            new Wrap(
              spacing: 1.0,
              runSpacing: 2.0,
              children:
                  List<Widget>.generate(widget._sentence.word.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      print('gesture detector');
                      symbolTextEditingController.text =
                          widget._sentence.word[index].name;
                      displayNameTextEditingController.text =
                          widget._sentence.word[index].displayName;
                      currentWordIndex = index;
                    });
                  },
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/symbols/' +
                                  widget._sentence.word[index].imagePath,

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
                                    widget._sentence.word[index].displayName ==
                                            widget._sentence.word[index].name
                                        ? '${widget._sentence.word[index].name}'
                                        : '${widget._sentence.word[index].displayName} (${widget._sentence.word[index].name})',
                                    style: GoogleFonts.didactGothic(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

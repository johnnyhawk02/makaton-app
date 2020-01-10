import 'package:webmakaton/sentence.dart';
//import '../imagePaths.dart' show imagePaths;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webmakaton/word_list.dart';
import 'package:webmakaton/imagePaths.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
              child: Card(
                margin: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget._sentence.word[currentWordIndex].displayName ==
                                widget._sentence.word[currentWordIndex].name
                            ? '${widget._sentence.word[currentWordIndex].name}'
                            : '${widget._sentence.word[currentWordIndex].displayName} (${widget._sentence.word[currentWordIndex].name})',
                        style: GoogleFonts.didactGothic(
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          child: Image.asset(
                            'assets/images/symbols/' +
                                widget
                                    ._sentence.word[currentWordIndex].imagePath,

                            fit: BoxFit.contain,
                            height: 80,
                            //colorBlendMode: BlendMode.srcOver ,
                          ),
                        ),
//
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              keyboardType: TextInputType.text,
                              controller: symbolTextEditingController,
                              onChanged: (text) {
                                setState(() {
                                  widget._sentence
                                      .replace(currentWordIndex, text);
                                  widget._setTextEditingControllerText(
                                      widget._sentence.toString());
                                });
                              },
                              decoration: InputDecoration(
                                  labelText:
                                      'Symbol for ${widget._sentence.word[currentWordIndex].displayName}',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      setState(() {
                                        symbolTextEditingController.clear();
                                      });
                                    }, // _clearTextField,
                                  ),
                                  hintText: 'Symbol Name'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CarouselSlider.builder(
              viewportFraction: 0.333,
              enableInfiniteScroll: false,
              aspectRatio: 16/4,
              onPageChanged: (index) {
                setState(() {
                  currentWordIndex = index;
                });
              },
              itemCount: widget._sentence.word.length,
              itemBuilder: (BuildContext context, int itemIndex) =>
                  GestureDetector(
                onTap: () {
                  setState(() {
                    print('gesture detector');
                    symbolTextEditingController.text =
                        widget._sentence.word[itemIndex].name;
                    displayNameTextEditingController.text =
                        widget._sentence.word[itemIndex].displayName;
                    currentWordIndex = itemIndex;
                  });
                },
                child: Container(

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn,
                            height: currentWordIndex==itemIndex?50:30,

                            child: Image.asset(
                              'assets/images/symbols/' +
                                  widget._sentence.word[itemIndex].imagePath,

                              fit: BoxFit.contain,
                              height: currentWordIndex==itemIndex?60:30,
                              //colorBlendMode: BlendMode.srcOver ,
                            ),
                          ),
//
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  widget._sentence.word[itemIndex]
                                              .displayName ==
                                          widget._sentence.word[itemIndex].name
                                      ? '${widget._sentence.word[itemIndex].name}'
                                      : '${widget._sentence.word[itemIndex].displayName} (${widget._sentence.word[itemIndex].name})',
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
              ),
            ),
           ],
        ),
      ),
    );
  }
}

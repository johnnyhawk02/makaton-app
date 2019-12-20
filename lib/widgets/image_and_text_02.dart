import 'package:flutter/material.dart';
import '../sentence.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageAndText extends StatelessWidget {
  const ImageAndText({
    Key key,
    @required Sentence sentence,
    Image image,
    bool typing,
    Function fn,
   })  : _sentence = sentence,
        _image = image,
        _typing = typing,
        _fn = fn,
        super(key: key);

  final Sentence _sentence;
  final Image _image;
  final bool _typing;
  final Function _fn;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                height: _typing?1:400,
                child: _image,//_typing? Container():_image,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              //mainAxisAlignment: MainAxisAlignment.center,
              spacing: 15.0, // gap between adjacent chips
              runSpacing: 25.0, // gap between lines
              children: List<Widget>.generate(_sentence.word.length, (index) {
                return InkWell(
                  onTap: () =>
                    _fn()
                  ,
                  child: Column(
                    children: [
                      Image.asset(
                        _sentence.word[index].isKeyword
                            ? 'assets/images/symbols/' +
                                _sentence.word[index].imagePath
                            : 'assets/images/blank.jpg',
                        fit: BoxFit.contain,
                        height: MediaQuery.of(context).size.width * 0.175,
                        //colorBlendMode: BlendMode.srcOver ,
                      ),
                      Text(
                        _sentence.word[index].displayName,
                        style: GoogleFonts.didactGothic(

                          fontWeight: FontWeight.normal,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../sentence.dart';

class ImageAndText extends StatelessWidget {
  const ImageAndText({
    Key key,
    @required Sentence sentence,
    Image image,
    bool rotate,
    Function fn,
  })  : _sentence = sentence,
        _image = image,
        _rotate = rotate,
        _fn = fn,
        super(key: key);

  final Sentence _sentence;
  final Image _image;
  final bool _rotate;
  final Function _fn;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              child: Container(
                child: _image,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              //mainAxisAlignment: MainAxisAlignment.center,
              spacing: 5.0, // gap between adjacent chips
              runSpacing: 10.0, // gap between lines
              children: List<Widget>.generate(_sentence.word.length, (index) {
                return InkWell(
                  onTap: () =>
                    _fn()
                  ,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.asset(
                          _sentence.word[index].isKeyword
                              ? 'assets/images/symbols/' +
                                  _sentence.word[index].imagePath
                              : 'assets/images/blank.jpg',
                          fit: BoxFit.contain,
                          height: 60,
                          //colorBlendMode: BlendMode.srcOver ,
                        ),
                        Text(
                          _sentence.word[index].displayName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
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

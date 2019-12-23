import 'package:webmakaton/sentence.dart';
import 'package:webmakaton/sentence.dart';
import '../imagePaths.dart' show imagePaths;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//import 'package:flutter/foundation.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({
    Key key,
    @required Sentence sentence,
  })  : _sentence = sentence,
        super(key: key);

  final Sentence _sentence;

  @override
  Widget build(BuildContext context) {
    return new GridView.count(
      childAspectRatio: 1.4,
      crossAxisCount: 3,
      children: List<Widget>.generate(_sentence.word.length, (index) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Card(
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
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

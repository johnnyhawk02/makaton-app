import 'package:webmakaton/sentence.dart';
import 'package:webmakaton/sentence.dart';
import '../imagePaths.dart' show imagePaths;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//import 'package:flutter/foundation.dart';

class SignAndSymbol extends StatelessWidget {
  const SignAndSymbol({
    Key key,
    @required Sentence sentence,
  })  : _sentence = sentence,
        super(key: key);

  final Sentence _sentence;
  final index = 0;
  @override
  Widget build(BuildContext context) {
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
                        height: MediaQuery.of(context).size.width * 0.2,
                        //colorBlendMode: BlendMode.srcOver ,
                      ),

                      Image.asset(
                         'assets/images/signs/' +
                            _sentence.word[index].imagePath,

                        fit: BoxFit.contain,
                        height: MediaQuery.of(context).size.width * 0.7,
                        //colorBlendMode: BlendMode.srcOver ,
                      ),
                      Text(
                        _sentence.word[index].displayName,
        style: GoogleFonts.didactGothic(

        fontWeight: FontWeight.normal,
        fontSize: MediaQuery.of(context).size.width * 0.2,
                      ),

                      ),],
                  ),

                ],
              ),
            ),
          ],
        );

  }
}

import 'package:webmakaton/sentence.dart';
import 'package:webmakaton/sentence.dart';
import '../imagePaths.dart' show imagePaths;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webmakaton/word_list.dart';
//import 'package:flutter/foundation.dart';

class SignAndSymbol extends StatefulWidget {

  const SignAndSymbol({
    Key key,
    @required Sentence sentence,
  })  : _sentence = sentence,
        super(key: key);

  final Sentence _sentence;
  @override
  _SignAndSymbolState createState() => _SignAndSymbolState();
}

class _SignAndSymbolState extends State<SignAndSymbol> {
  int index = 0;
  List<String> myList; // = WordList.randomList(5);

  String _currentItemSelected;
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
                  FloatingActionButton (
                    onPressed: _generateRandomList,
                  ),
                  Image.asset(
                    'assets/images/symbols/${
                        imagePaths.containsKey(_currentItemSelected)?
                        imagePaths[_currentItemSelected]:imagePaths['cat']}',
                    fit: BoxFit.contain,
                    height: MediaQuery.of(context).size.width * 0.2,
                    //colorBlendMode: BlendMode.srcOver ,
                  ),
                  Image.asset(
                    'assets/images/signs/${
                        imagePaths.containsKey(_currentItemSelected)?
                    imagePaths[_currentItemSelected]:imagePaths['cat']}',

                    fit: BoxFit.contain,
                    height: MediaQuery.of(context).size.width * 0.7,
                    //colorBlendMode: BlendMode.srcOver ,
                  ),
                  Text(
                    _currentItemSelected!=null?_currentItemSelected:'nuffink',
                    style: GoogleFonts.didactGothic(
                      fontWeight: FontWeight.normal,
                      fontSize: MediaQuery.of(context).size.width * 0.1,
                    ),
                  ),
                  DropdownButton<String>(

                    items: myList==null?[]:myList.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/symbols/${
                                  imagePaths.containsKey(dropDownStringItem)?
                                  imagePaths[dropDownStringItem]:imagePaths['cat']}',
                              fit: BoxFit.contain,
                              height: MediaQuery.of(context).size.width * 0.1,
                              //colorBlendMode: BlendMode.srcOver ,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(dropDownStringItem),
                            ),
                          ],
                        ),
                      );
                    }).toList(),

                    onChanged: (String newValueSelected) {
                      // Your code to execute, when a menu item is selected from drop down
                      _onDropDownItemSelected(newValueSelected);
                    },

                    value: _currentItemSelected,

                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _generateRandomList(){
    setState(() {
      myList = WordList.randomList(5);
    });

  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }
}

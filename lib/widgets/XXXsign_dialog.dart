import 'package:flutter/material.dart';

import '../sentence.dart';

class SignDialog extends StatelessWidget {
  const SignDialog({
    Key key,
    @required setTextFieldText,
    @required Sentence sentence,
  })  : _setTextFieldText = setTextFieldText,
        _sentence = sentence,
        super(key: key);

  final Function _setTextFieldText;
  final Sentence _sentence;

  @override
  Widget build(BuildContext context) {
    final index=0;
    return AlertDialog(
      title: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => _setTextFieldText(
                'hello my little ${_sentence.word[index].displayName}'),
            child: Image.asset(
              'assets/images/symbols/' + _sentence.word[index].imagePath,

              fit: BoxFit.contain,
              height: MediaQuery.of(context).size.width * 0.1,
              //colorBlendMode: BlendMode.srcOver ,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text("${_sentence.word[index].displayName}"),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            'assets/images/signs/' + _sentence.word[index].imagePath,

            fit: BoxFit.contain,
            height: MediaQuery.of(context).size.width * 0.99,
            //colorBlendMode: BlendMode.srcOver ,
          ),
        ],
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
  }
}

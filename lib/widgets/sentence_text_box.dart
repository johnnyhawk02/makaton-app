
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../sentence.dart';

class SentenceTextBox extends StatelessWidget {
  //final TextEditingController _textEditingController = TextEditingController();

  const SentenceTextBox({
    Key key,
    @required Sentence sentence,
    @required text,
    @required textEditingController,
    @required setTextFieldText,
    //@required setSentence,
    @required clearTextField,

  })  : _text = text,
       // _setSentence = setSentence,
        _sentence = sentence,
        _setTextFieldText = setTextFieldText,
        _textEditingController = textEditingController,
        _clearTextField = clearTextField,
        super(key: key);

  final String _text;
  final Sentence _sentence;
  final _setTextFieldText;
  //final _setSentence;
  final _clearTextField;
  final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        controller: _textEditingController,
        onChanged: (text) {
          _setTextFieldText(text);
         // print("First text field: $text");
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: _clearTextField,

            ),
            hintText: 'Enter your sentence'),
      ),
    );
  }
}

import 'imagePaths.dart' show imagePaths;
import 'functions.dart';

class Word {
  String _wd;
  String _imagePath;
  String _name;
  String _displayName;
  bool _isKeyword;

  Word(this._wd) {
    _initialize();
  }

  void _initialize() {
     if (_wd.contains('-')){
      _wd = removeDash(_wd);
      _isKeyword = false;
    }else{
      _isKeyword = true;
    }
    if (_wd.contains("(")) {
      _name = insideBrackets(_wd);
      _displayName = beforeBrackets(_wd) + afterBrackets(_wd);
    } else {
      _name = _wd;
      _displayName = _wd;
    }
    String cleanedWord = (removeIllegalCharacters(_name)).toLowerCase();
    if (imagePaths.containsKey(cleanedWord)) {
      _imagePath = imagePaths[cleanedWord];
    } else {
      _imagePath = "blank.jpg";
    }
  }

  String get name => _name;
  String get displayName => _displayName;
  String get imagePath => _imagePath;
  bool get isKeyword => _isKeyword;
 

}

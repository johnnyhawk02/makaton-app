import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webmakaton/widgets/image_grid.dart';
import 'package:webmakaton/widgets/sign_and_symbol.dart';
import "word_list.dart" show WordList;
import 'imagePaths.dart' show imagePaths;
import 'package:webmakaton/widgets/image_and_text_03.dart' show ImageAndText;
import 'sentence.dart' show Sentence;
 import 'dart:async';
import 'dart:io';
 import 'package:permission_handler/permission_handler.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:webmakaton/widgets/image_grid.dart';
import 'package:webmakaton/widgets/sentence_text_box.dart';
import 'package:webmakaton/widgets/screen_shot_and_save.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  permissions();
  runApp(MyApp());
}

void permissions() async {
  Map<PermissionGroup, PermissionStatus> permissions =
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool typing = false;
  String _text = 'cow ostrich llama goat sheep octopus reindeer';
  Sentence sentence = Sentence('cow');
   String _appBarTitle = 'Makaton';
   final TextEditingController textEditingController = TextEditingController();
  File _image;

void setTextEditingControllerText(text) {
  setState(() {
    //_text = text;
    sentence = Sentence(text);
    textEditingController.text = text;
  });

}
  void setTextFieldText(text) {
    print(textEditingController.text);
    setState(() {
      //_text = text;
      sentence = Sentence(text);
     // textEditingController.text = text;
    });
  }

  void clearTextField() {
    setState(
      () {
        print(textEditingController.text);
        sentence = Sentence('');
        _text = 'cleared';

        textEditingController.text = '';
      },
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          print('keyboard visible $visible');
          typing = visible;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text(_appBarTitle),
            actions: <Widget>[],
          ),
          body: TabBarView(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SentenceTextBox(
                      textEditingController: textEditingController,
                      clearTextField: clearTextField,
                      setTextFieldText: setTextFieldText,
                       sentence: sentence,
                      text: _text,
                    ),
                    Container(
                        height: 900,
                        child: ImageAndText(

                          getImage: getImage,
                          sentence: sentence,
                          typing: typing,
                          image: _image != null
                              ? Image.file(_image)
                              : Image.asset('assets/images/symbols/c/cat.jpg'),
                        )),
                  ],
                ),
              ),
              ImageGrid(
                setTextEditingControllerText: setTextEditingControllerText,
                sentence: sentence,
              ),
              SingleChildScrollView(
                child: ScreenShotAndSave(
                    child: ImageAndText(

                      getImage: getImage,
                      sentence: sentence,
                      typing: typing,
                      image: _image != null
                          ? Image.file(_image)
                          : Image.asset('assets/images/symbols/c/cat.jpg'),
                    ),
                ),
              )
            ],
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.settings),
              ),
              Tab(
                icon: Icon(Icons.sentiment_very_satisfied),
              ),
            ],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black54,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.black,
          ),
        ),
      ),
    );
  }
}

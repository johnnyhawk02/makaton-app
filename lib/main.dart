import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webmakaton/widgets/image_grid.dart';
import 'package:webmakaton/widgets/sentence_editor.dart';
import 'package:webmakaton/widgets/sign_and_symbol.dart';
import 'package:webmakaton/sentence.dart';
import "word_list.dart" show WordList;
import 'imagePaths.dart' show imagePaths;
import 'package:webmakaton/widgets/image_and_text_03.dart' show ImageAndText;
//import 'sentence.dart' show Sentence;
import 'dart:async';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:webmakaton/widgets/image_grid.dart';
import 'package:webmakaton/widgets/sentence_text_box.dart';
import 'package:webmakaton/widgets/screen_shot_and_save.dart';
import 'widgets/random_word.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
  //String _text = 'cow ostrich llama goat sheep octopus reindeer';
  Sentence sentence = Sentence('cow');
  String _appBarTitle = 'Makaton';
  final TextEditingController textEditingController = TextEditingController();
  File _image;
  int _currentIndex = 0;
  List<Widget> _children = [];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void setTextEditingControllerText(text) {
    setState(() {
      //_text = text;
      print('executing setTextEditingControllerText');
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
        //_text = 'cleared';

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
    _children = [
      Center(child: RandomWord()),
      Container(
        //height: 1600,
        child: Column(

          mainAxisSize: MainAxisSize.max,
          children: <Widget>[

            Center(
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
            ),
          ],
        ),
      ),
      Column(
        children: <Widget>[
          SentenceTextBox(
            textEditingController: textEditingController,
            clearTextField: clearTextField,
            setTextFieldText: setTextFieldText,
            sentence: sentence,
            //text: _text,
          ),

          SentenceEditor(
            setTextEditingControllerText: setTextEditingControllerText,
            sentence: sentence,
          ),
        ],
      )
    ];
    return MaterialApp(
      home: Scaffold(
        backgroundColor:Colors.grey[200],


        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text(_appBarTitle),
          actions: <Widget>[],
        ),
        body: SingleChildScrollView(child: _children[_currentIndex]),


        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () => onTabTapped(0),
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () => onTabTapped(1),

              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped, // new
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.sentiment_very_satisfied),
              title: new Text('Randomaton'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.view_list),
              title: new Text('Story View'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.mode_edit), title: Text('Edit Story'))
          ],
        ),
      ),
    );
  }
}

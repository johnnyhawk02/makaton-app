import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import "word_list.dart" show WordList;
import 'imagePaths.dart' show imagePaths;
import 'package:webmakaton/widgets/image_and_text_02.dart' show ImageAndText;
import 'sentence.dart' show Sentence;
import 'package:screenshot/screenshot.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

//void main(){
//  WordList.randomList(100).forEach(
//          (word){
//    print (word);3
//  },
//});

void main() {
  permissions();
  runApp(new MyApp());
}



void permissions() async {
  Map<PermissionGroup, PermissionStatus> permissions =
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _imageList = WordList.randomList(100);
  File _image;
  bool _rotate = false;
  bool typing = false;
  Sentence sentence = Sentence('We -are going(go) -to -the Zoo');
  File _imageFile;
  final ScreenshotController screenshotController = ScreenshotController();
  final TextEditingController _textEditingController = new TextEditingController();

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(

          title: new Text("Exporting Image..."),
          content:  Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(child: CircularProgressIndicator()),
            ],
          ),

          actions: <Widget>[
            // usually buttons at the bottom of the dialog
//            new FlatButton(
//              child: new Text("Close"),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
          ],
        );
      },
    );
  }

  void random() {
    setState(() {
      _imageList = WordList.randomList(100);
      print(_imageList[0]);
    });
  }

  void rotate() {
    setState(() {
      _rotate = !_rotate;
    });
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  void screenShot() {
    _showDialog();
    permissions();
    _imageFile = null;
    double _ratio =
        2480 / MediaQuery.of(context).size.width; //scale to A4 paper width
    screenshotController.capture(pixelRatio: _ratio).then((File image) async {
      //print("Capture Done");
      setState(() {
        _imageFile = image;
      });
      final result = await ImageGallerySaver.saveImage(image
          .readAsBytesSync()); // Save image to gallery,  Needs plugin  https://pub.dev/packages/image_gallery_saver

      Navigator.of(context).maybePop();
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: Text('hi'),
        actions: <Widget>[
          buildAppBarButtons(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textEditingController,
                //keyboardType: TextInputType.multiline,
                onChanged: (text) {
                  setState(() {
                    sentence = Sentence(text);
                  });
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            sentence = Sentence('');
                            _textEditingController.clear();
                          });
                        }),

                    hintText: 'Enter your sentence'),

              ),
            ),
            Screenshot(
              controller: screenshotController,
              child: Column(
                children: <Widget>[
                  ImageAndText(
                      //sentence: sentence, image:  Image.file(_image), rotate: _rotate),
                      sentence: sentence,
                      image: _image != null
                          ? Image.file(_image)
                          : Image.asset('assets/images/symbols/c/cat.jpg'),
                      rotate: _rotate),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildAppBarButtons() {
    return Row(
          children: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: screenShot,
              child: Icon(Icons.mobile_screen_share),
            ),
            FlatButton(
              textColor: Colors.white,
              onPressed: rotate,
              child: Icon(Icons.rotate_left),
            ),
//              FlatButton(
//                textColor: Colors.white,
//                onPressed: random,
//                child: Text("Randomize"),
//              ),
            FlatButton(
              textColor: Colors.white,
              onPressed: getImage,
              child: Icon(Icons.image),
            ),
          ],
        );
  }
}
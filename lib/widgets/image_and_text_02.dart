
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import '../sentence.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:async';
import 'dart:io';

class ImageAndText extends StatelessWidget {
  const ImageAndText({
    Key key,
    @required Sentence sentence,
    ScreenshotController screenshotController,
    File imageFile,
    Image image,
    bool typing,
    Function fn,
    Function getImage,
    Function setStateImageFile,
    Function setStateImageFileToNull,
  })  : _screenshotController = screenshotController,
        _sentence = sentence,
        _imageFile = imageFile,
        _image = image,
        _typing = typing,
        _fn = fn,
        _getImage = getImage,
        _setStateImageFile = setStateImageFile,
        _setStateImageFileToNull = setStateImageFileToNull,
        super(key: key);
  final File _imageFile;
  final Function _getImage;
  final Sentence _sentence;
  final Image _image;
  final bool _typing;
  final Function _fn;
  final ScreenshotController _screenshotController;
  final Function _setStateImageFile;
  final Function _setStateImageFileToNull;


  void permissions() async {
   // print ('hi permissions here');
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    print (permissions);
  }


  @override
  Widget build(BuildContext context) {
//
//    void _showDialog() {
//      // flutter defined function
//      showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          // return object of type Dialog
//          return AlertDialog(
//            title: new Text("Image exported"),
//            content: Column(
//              mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//                Center(child: CircularProgressIndicator()),
//              ],
//            ),
//            actions: <Widget>[
//              // usually buttons at the bottom of the dialog
////            new FlatButton(
////              child: new Text("Close"),
////              onPressed: () {
////                Navigator.of(context).pop();
////              },
////            ),
//            ],
//          );
//        },
//      );
//    }

//    void screenShot() {
//      _showDialog();
//      permissions();
//      //_imageFile = null;
//      _setStateImageFileToNull();
//      double _ratio =
//          2480 / MediaQuery.of(context).size.width; //scale to A4 paper width
//      _screenshotController.capture(pixelRatio: _ratio).then((File image) async {
//        print("Capture Done");
//        _setStateImageFile(image);
//
//        final result = await ImageGallerySaver.saveImage(image
//            .readAsBytesSync()); // Save image to gallery,  Needs plugin  https://pub.dev/packages/image_gallery_saver
//        Navigator.of(context, rootNavigator: true).maybePop(result);
//        //Navigator.of(context).maybePop();
//      }).catchError((onError) {
//        print(onError);
//      });
//    }

    return Screenshot(
      controller: _screenshotController,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FlatButton(
                onPressed: _getImage,
                child: Text('Click me')


            ),
//            FlatButton(
//                onPressed: screenShot,
//                child: Text('screenshoot')
//
//
//            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                child: GestureDetector(
                  onTap: _getImage,
                  child: AnimatedContainer(

                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    width: _typing ? 1 : 400,
                    child: _image, //_typing? Container():_image,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                //mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15.0, // gap between adjacent chips
                runSpacing: 25.0, // gap between lines
                children: List<Widget>.generate(_sentence.word.length, (index) {
                  return InkWell(
                    onTap: () {
                      _sentence.replace(index, 'camel');
                      _fn(_sentence.toString());
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          _sentence.word[index].isKeyword
                              ? 'assets/images/symbols/' +
                                  _sentence.word[index].imagePath
                              : 'assets/images/blank.jpg',
                          fit: BoxFit.contain,
                          height: MediaQuery.of(context).size.width * 0.175,
                          //colorBlendMode: BlendMode.srcOver ,
                        ),
                        Text(
                          _sentence.word[index].displayName,
                          style: GoogleFonts.didactGothic(
                            fontWeight: FontWeight.normal,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

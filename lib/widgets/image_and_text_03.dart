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
    // remove ... ScreenshotController screenshotController,
    File imageFile,
    Image image,
    bool typing,
    Function fn,
    Function getImage,
    Function setStateImageFile,
    Function setStateImageFileToNull,
  })  : // remove ... _screenshotController = screenshotController,
        _sentence = sentence,
        _imageFile = imageFile,
        _image = image,
        _typing = typing,
        _fn = fn,
        _getImage = getImage,
        // remove ... _setStateImageFile = setStateImageFile,
        // remove ... _setStateImageFileToNull = setStateImageFileToNull,
        super(key: key);
  final File _imageFile;
  final Function _getImage;
  final Sentence _sentence;
  final Image _image;
  final bool _typing;
  final Function _fn;
  // remove ... final ScreenshotController _screenshotController;
  // remove ... final Function _setStateImageFile;
  // remove ... final Function _setStateImageFileToNull;

  void permissions() async {
    // print ('hi permissions here');
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    print(permissions);
  }

  @override
  Widget build(BuildContext context) {


    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,

          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 10.0),
              child: Text(
                'Makaton stories',
                style: GoogleFonts.didactGothic(
                  fontWeight: FontWeight.normal,
                  fontSize: 35,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
              child: Text(
                'Subtitle here',
                style: GoogleFonts.didactGothic(
                  fontWeight: FontWeight.normal,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                child: GestureDetector(
                  onTap: _getImage,
                  child: _image,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Wrap(
                //mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15.0, // gap between adjacent chips
                runSpacing: 25.0, // gap between lines
                children: List<Widget>.generate(_sentence.word.length, (index) {
                  return Column(
                    children: [
                      Image.asset(
                        _sentence.word[index].isKeyword
                            ? 'assets/images/symbols/' +
                                _sentence.word[index].imagePath
                            : 'assets/images/blank.jpg',
                        fit: BoxFit.contain,
                        height: 30,
                        //colorBlendMode: BlendMode.srcOver ,
                      ),
                      Text(
                        _sentence.word[index].displayName,
                        style: GoogleFonts.didactGothic(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                    ],
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

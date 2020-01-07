import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

void permissions() async {
  Map<PermissionGroup, PermissionStatus> permissions =
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
}

class ScreenShotAndSave extends StatefulWidget {
  final Widget child;
  final Function takeScreenShot;
  const ScreenShotAndSave({
    Key key,
    this.child,
    this.takeScreenShot,
  }) : super(key: key);

  @override
  _ScreenShotAndSaveState createState() => _ScreenShotAndSaveState();
}

class _ScreenShotAndSaveState extends State<ScreenShotAndSave> {
  ScreenshotController screenshotController = ScreenshotController();

  File _imageFile;
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Exporting Image..."),
          content: Column(
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

      Navigator.of(context, rootNavigator: true).maybePop(result);
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.width * 1.41429,
          child: Screenshot(
            controller: screenshotController,
            child: widget.child,
          ),
        ),
        Positioned(
          top: 5.0,
          right: 10.0,
          child: RaisedButton(
            color: Colors.white,
            onPressed: screenShot,
            elevation: 3,
            child: Icon(Icons.file_download),
          ),
        ),
      ],
    );
  }
}

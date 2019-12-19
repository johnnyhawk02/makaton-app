import '../imagePaths.dart' show imagePaths;
import 'package:flutter/material.dart';
//import 'package:flutter/foundation.dart';

class ImageAndText extends StatelessWidget {
  const ImageAndText({
    Key key,
    @required List<String> imageList,
  })  : _imageList = imageList,
        super(key: key);

  final List<String> _imageList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: new GridView.count(
        childAspectRatio: 1.5,
        crossAxisCount: 3,
        children: new List<Widget>.generate(60, (index) {
          return Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/symbols/' +
                              imagePaths[_imageList[index]],
                          fit: BoxFit.contain,
                          width: 75,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Text(
                            _imageList[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/images/signs/' + imagePaths[_imageList[index]],
                      fit: BoxFit.contain,
                      width: 280,
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

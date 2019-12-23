import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => new _TestState();
}

class _TestState extends State<Test> {
  var _img = new Image.network(
      "https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/TUCPamplona10.svg/500px-TUCPamplona10.svg.png");
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Test Drop"),
      ),
      body: new Center(
        child: new Container(
          height: 50.0,
          child: new DropdownButton(
              items: new List.generate(10, (int index) {
                return new DropdownMenuItem(
                    child: new Container(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  height: 100.0,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[_img, new Text("Under 10")],
                  ),
                ));
              }),
              onChanged: null),
        ),
      ),
    );
  }
}

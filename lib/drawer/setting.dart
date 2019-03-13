import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          centerTitle: true,
          title: new Text("设置"),
        ),
        body: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Fluttertoast.showToast(msg: "设置");
              },
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        "切换主题",
                        style: TextStyle(fontSize: 16),
                      )),
                      new Image.asset(
                        "images/arrow_right.png",
                        width: 16,
                        height: 16,
                      )
                    ],
                  )),
            ),
            Divider(
              height: 1,
            ),
            InkWell(
              onTap: () {
                Fluttertoast.showToast(msg: "设置");
              },
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        "切换主题",
                        style: TextStyle(fontSize: 16),
                      )),
                      new Image.asset(
                        "images/arrow_right.png",
                        width: 16,
                        height: 16,
                      )
                    ],
                  )),
            ),
            Divider(
              height: 1,
            ),
          ],
        ));
  }
}

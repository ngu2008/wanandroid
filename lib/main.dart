import 'package:flutter/material.dart';
import 'package:wanandroid_ngu/common/user.dart';
import './app.dart';
import './loading.dart';
import 'dart:io';
import 'package:flutter/services.dart';

void main(){
  getLoginInfo();

  runApp(MyApp());
  if (Platform.isAndroid) {
// 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

Future<Null> getLoginInfo() async {
  User.singleton.getUserInfo();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "玩Android",
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: const Color(0xFF5394FF),
        scaffoldBackgroundColor: Color(0xFFebebeb),
        accentColor: const Color(0xFF5394FF),
      ),

      routes: <String, WidgetBuilder>{
        "app": (BuildContext context) => new App(),
      },

      home: new LoadingPage(),
    );
  }
}

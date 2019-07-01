import 'package:flutter/material.dart';
import 'package:wanandroid_ngu/common/application.dart';
import 'package:wanandroid_ngu/common/user.dart';
import 'package:wanandroid_ngu/event/change_theme_event.dart';
import 'package:wanandroid_ngu/splash_screen.dart';
import 'package:wanandroid_ngu/util/theme_util.dart';
import 'package:wanandroid_ngu/util/utils.dart';
import './app.dart';
import './loading.dart';
import 'dart:io';
import 'package:flutter/services.dart';

void main() {
  getLoginInfo();
  runApp(MyApp());
  if (Platform.isAndroid) {
// 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

Future<Null> getLoginInfo() async {
  User.singleton.getUserInfo();
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {

  Color themeColor = ThemeUtils.currentColorTheme;
  @override
  void initState() {
    super.initState();
    Utils.getColorThemeIndex().then((index) {
      print('color theme index = $index');
      if (index != null) {
        ThemeUtils.currentColorTheme = ThemeUtils.supportColors[index];
        Application.eventBus
            .fire(new ChangeThemeEvent(ThemeUtils.supportColors[index]));
      }
    });

    Application.eventBus.on<ChangeThemeEvent>().listen((event) {
      setState(() {
        themeColor = event.color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "玩Android",
      debugShowCheckedModeBanner: false,
      theme:
          new ThemeData(primaryColor: themeColor, brightness: Brightness.light),
      routes: <String, WidgetBuilder>{
        "app": (BuildContext context) => new App(),
        "splash": (BuildContext context) => new SplashScreen(),
      },
      home: new LoadingPage(),
    );
  }
}

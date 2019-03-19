import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:wanandroid_ngu/common/application.dart';
import 'package:wanandroid_ngu/common/user.dart';
import 'package:wanandroid_ngu/event/change_theme_event.dart';
import 'package:wanandroid_ngu/event/login_event.dart';
import 'package:wanandroid_ngu/ui/drawer/about.dart';
import 'package:wanandroid_ngu/ui/drawer/collctions.dart';
import 'package:wanandroid_ngu/ui/drawer/common_website.dart';
import 'package:wanandroid_ngu/ui/drawer/pretty.dart';
import 'package:wanandroid_ngu/ui/login/login_page.dart';
import 'package:wanandroid_ngu/util/theme_util.dart';
import 'package:wanandroid_ngu/util/utils.dart';

class DrawerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DrawerPageState();
  }
}

class DrawerPageState extends State<DrawerPage> {
  bool isLogin = false;
  String username = "未登录";

  @override
  void initState() {
    super.initState();
    this.registerLoginEvent();
    if (null != User.singleton.userName) {
      isLogin = true;
      username = User.singleton.userName;
    }
  }

  void registerLoginEvent() {
    Application.eventBus.on<LoginEvent>().listen((event) {
      changeUI();
    });
  }

  changeUI() async {
    setState(() {
      isLogin = true;
      username = User.singleton.userName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: InkWell(
              child: Text(username,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              onTap: () {
                if (!isLogin) {
                  Navigator.of(context)
                      .push(new MaterialPageRoute(builder: (context) {
                    return new LoginPage();
                  }));
                }
              },
            ),
            currentAccountPicture: InkWell(
              child: CircleAvatar(
                backgroundImage: AssetImage('images/head.jpg'),
              ),
              onTap: () {
                if (!isLogin) {
                  Navigator.of(context)
                      .push(new MaterialPageRoute(builder: (context) {
                    return new LoginPage();
                  }));
                }
              },
            ),
          ),
          ListTile(
            title: Text(
              '我的收藏',
              textAlign: TextAlign.left,
            ),
            leading: Icon(Icons.collections, size: 22.0),
            onTap: () {
              if (isLogin) {
                onCollectionClick();
              } else {
                onLoginClick();
              }
            },
          ),
          ListTile(
            title: Text(
              '常用网站',
              textAlign: TextAlign.left,
            ),
            leading: Icon(Icons.web, size: 22.0),
            onTap: () {
              Navigator.of(context)
                  .push(new MaterialPageRoute(builder: (context) {
                return new CommonWebsitePage();
              }));
            },
          ),
          ListTile(
            title: Text(
              '主题',
              textAlign: TextAlign.left,
            ),
            leading: Icon(Icons.settings, size: 22.0),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return new SimpleDialog(
                    title: Text("设置主题"),
                    children: ThemeUtils.supportColors.map((Color color) {
                      return new SimpleDialogOption(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                          height: 35,
                          color: color,
                        ),
                        onPressed: () {
                          ThemeUtils.currentColorTheme = color;
                          Utils.setColorTheme(
                              ThemeUtils.supportColors.indexOf(color));
                          changeColorTheme(color);
                          Navigator.of(context).pop();
                        },
                      );
                    }).toList(),
                  );
                },
              );
            },
          ),
          ListTile(
            title: Text(
              '分享',
              textAlign: TextAlign.left,
            ),
            leading: Icon(Icons.share, size: 22.0),
            onTap: () {
              Share.share(
                  '给你推荐一个特别好玩的应用玩安卓客户端，点击下载：https://www.pgyer.com/haFL');
            },
          ),
          ListTile(
            title: Text(
              '妹子图',
              textAlign: TextAlign.left,
            ),
            leading: Icon(Icons.directions_bike, size: 22.0),
            onTap: () {
              Navigator.of(context)
                  .push(new MaterialPageRoute(builder: (context) {
                return new PrettyPage();
              }));
            },
          ),
          ListTile(
            title: Text(
              '关于作者',
              textAlign: TextAlign.left,
            ),
            leading: Icon(Icons.info, size: 22.0),
            onTap: () {
              Navigator.of(context)
                  .push(new MaterialPageRoute(builder: (context) {
                return new AboutMePage();
              }));
            },
          ),
          logoutWidget()
        ],
      ),
    );
  }

  Widget logoutWidget() {
    if (User.singleton.userName != null) {
      return ListTile(
        title: Text(
          '退出登录',
          textAlign: TextAlign.left,
        ),
        leading: Icon(Icons.power_settings_new, size: 22.0),
        onTap: () {
          User.singleton.clearUserInfor();
          setState(() {
            isLogin = false;
            username = "未登录";
          });
        },
      );
    } else {
      return SizedBox(
        height: 0,
      );
    }
  }

  void onCollectionClick() async {
    await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new CollectionsPage();
    }));
  }

  void onLoginClick() async {
    await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new LoginPage();
    }));
  }

  changeColorTheme(Color c) {
    Application.eventBus.fire(new ChangeThemeEvent(c));
  }
}

import 'package:flutter/material.dart';
import 'package:wanandroid_ngu/http/common_service.dart';
import 'package:wanandroid_ngu/model/NaviModel.dart';
import 'package:wanandroid_ngu/public_ui/webview_page.dart';
import 'package:wanandroid_ngu/util/utils.dart';

class NavigationPage extends StatefulWidget {
  @override
  NavigationState createState() {
    return new NavigationState();
  }
}

class NavigationState extends State<NavigationPage> {
  List<NaviData> _naviTitles = new List();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<Null> _getData() async {
    CommonService().getNaviList((NaviModel _naviData) {
      setState(() {
        _naviTitles = _naviData.data;
      });
    });
  }

  // _rightListView(context)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      child: _rightListView(context),
      onRefresh: _getData,
    ));
  }

  Widget _rightListView(BuildContext context) {
    return ListView.separated(
        itemBuilder: _renderContent,
        itemCount: _naviTitles.length,
        physics: new AlwaysScrollableScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            height: 0.5,
            color: Colors.black26,
          );
        });
  }

  Widget _renderContent(BuildContext context, int index) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              _naviTitles[index].name,
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF3D4E5F),
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: buildChildren(_naviTitles[index].articles),
          ),
        ],
      ),
    );
  }

  Widget buildChildren(List<NaviArticle> children) {
    List<Widget> tiles = []; //先建一个数组用于存放循环生成的widget
    Widget content; //单独一个widg
    for (NaviArticle item in children) {
      tiles.add(new InkWell(
        child: new Chip(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: Utils.getChipBgColor(item.title),
            label: new Text(item.title)),
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return new WebViewPage(title: item.title, url: item.link);
          }));
        },
      ));
    }
    content = Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.start,
      children: tiles,
    );
    return content;
  }
}

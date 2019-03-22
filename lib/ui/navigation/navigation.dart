import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanandroid_ngu/base/_base_widget.dart';
import 'package:wanandroid_ngu/http/api_service.dart';
import 'package:wanandroid_ngu/model/navi_model.dart';
import 'package:wanandroid_ngu/ui/public_ui/webview_page.dart';
import 'package:wanandroid_ngu/util/utils.dart';

class NavigationPage extends BaseWidget {
  @override
  BaseWidgetState<BaseWidget> getState() {
    return NavigationState();
  }
}

class NavigationState extends BaseWidgetState<NavigationPage> {
  List<NaviData> _naviTitles = new List();
  //listview控制器
  ScrollController _scrollController = ScrollController();
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  @override
  void initState() {
    super.initState();
    setAppBarVisible(false);
    _getData();

    _scrollController.addListener(() {
      _scrollController.addListener(() {
        //当前位置是否超过屏幕高度
        if (_scrollController.offset < 200 && showToTopBtn) {
          setState(() {
            showToTopBtn = false;
          });
        } else if (_scrollController.offset >= 200 && showToTopBtn == false) {
          setState(() {
            showToTopBtn = true;
          });
        }
      });
    });
  }

  Future<Null> _getData() async {
    ApiService().getNaviList((NaviModel _naviData) {

      if (_naviData.errorCode == 0) {
        //成功
        if (_naviData.data.length > 0) {
          //有数据
          showContent();
          setState(() {
            _naviTitles = _naviData.data;
          });
        } else {
          //数据为空
          showEmpty();
        }
      } else {
        Fluttertoast.showToast(msg: _naviData.errorMsg);
      }

    },(DioError error) {
      //发生错误
      print(error.response);
      showError();
    });
  }



  Widget _rightListView(BuildContext context) {
    return ListView.separated(
        itemBuilder: _renderContent,
        itemCount: _naviTitles.length,
        controller: _scrollController,
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

  @override
  AppBar getAppBar() {
    return AppBar(
      title: Text("不显示"),
    );
  }


  @override
  Widget getContentWidget(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        displacement: 15,
        child: _rightListView(context),
        onRefresh: _getData,
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
          child: Icon(Icons.arrow_upward),
          onPressed: () {
            //返回到顶部时执行动画
            _scrollController.animateTo(.0,
                duration: Duration(milliseconds: 200), curve: Curves.ease);
          }),
    );
  }

  @override
  void onClickErrorWidget() {
    showloading();
    _getData();
  }
}

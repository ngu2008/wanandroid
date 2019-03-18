import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class BaseWidget extends StatefulWidget {

  BaseWidgetState baseWidgetState;

  @override
  BaseWidgetState createState() {
    baseWidgetState = getState();
    return baseWidgetState;
  }

  BaseWidgetState getState();
}

abstract class BaseWidgetState<T extends BaseWidget> extends State<T> {
  bool _isAppBarShow = true; //导航栏是否显示

  bool _isErrorWidgetShow = false; //错误信息是否显示
  String _errorContentMesage = "网络请求失败，请检查您的网络";
  String _errImgPath = "images/ic_error.png";

  bool _isLoadingWidgetShow = false;

  bool _isEmptyWidgetShow = false;
  String _emptyWidgetContent = "暂无数据~";
  String _emptyImgPath = "images/ic_empty.png"; //自己根据需求变更

  FontWeight _fontWidget = FontWeight.w600; //错误页面和空页面的字体粗度

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _getBaseAppBar(),
        body: Container(
          color: Colors.white, //背景颜色，可自己变更
          child: Stack(
            children: <Widget>[
              getContentWidget(context),
              _getBaseErrorWidget(),
              _getBaseEmptyWidget(),
              _getBassLoadingWidget(),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget getContentWidget(BuildContext context);

  ///暴露的错误页面方法，可以自己重写定制
  Widget getErrorWidget() {
    return Container(
      //错误页面中心可以自己调整
      padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage(_errImgPath),
              width: 120,
              height: 120,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(_errorContentMesage,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: _fontWidget,
                  )),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: OutlineButton(
                  child: Text("重新加载",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: _fontWidget,
                      )),
                  onPressed: () => {onClickErrorWidget()},
                ))
          ],
        ),
      ),
    );
  }

  Widget getLoadingWidget() {
    return Center(
        child: CupertinoActivityIndicator(
      radius: 15.0, //值越大加载的图形越大
    ));
  }

  Widget getEmptyWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                color: Colors.black12,
                image: AssetImage(_emptyImgPath),
                width: 150,
                height: 150,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(_emptyWidgetContent,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: _fontWidget,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _getBaseAppBar() {
    return PreferredSize(
        child: Offstage(
          offstage: !_isAppBarShow,
          child: getAppBar(),
        ),
        preferredSize: Size.fromHeight(50));
  }

  ///导航栏 appBar
  AppBar getAppBar();

  Widget _getBaseErrorWidget() {
    return Offstage(
      offstage: !_isErrorWidgetShow,
      child: getErrorWidget(),
    );
  }

  Widget _getBassLoadingWidget() {
    return Offstage(
      offstage: !_isLoadingWidgetShow,
      child: getLoadingWidget(),
    );
  }

  Widget _getBaseEmptyWidget() {
    return Offstage(
      offstage: !_isEmptyWidgetShow,
      child: getEmptyWidget(),
    );
  }

  ///点击错误页面后展示内容
  void onClickErrorWidget();

  ///设置错误提示信息
  void setErrorContent(String content) {
    if (content != null) {
      setState(() {
        _errorContentMesage = content;
      });
    }
  }

  ///设置导航栏隐藏或者显示
  void setAppBarVisible(bool isVisible) {
    setState(() {
      _isAppBarShow = isVisible;
    });
  }

  void showContent() {
    setState(() {
      _isEmptyWidgetShow = false;
      _isLoadingWidgetShow = false;
      _isErrorWidgetShow = false;
    });
  }

  void showloading() {
    setState(() {
      _isEmptyWidgetShow = false;
      _isLoadingWidgetShow = true;
      _isErrorWidgetShow = false;
    });
  }

  void showEmpty() {
    setState(() {
      _isEmptyWidgetShow = true;
      _isLoadingWidgetShow = false;
      _isErrorWidgetShow = false;
    });
  }

  void showError() {
    setState(() {
      _isEmptyWidgetShow = false;
      _isLoadingWidgetShow = false;
      _isErrorWidgetShow = true;
    });
  }

  ///设置空页面内容
  void setEmptyWidgetContent(String content) {
    if (content != null) {
      setState(() {
        _emptyWidgetContent = content;
      });
    }
  }

  ///设置错误页面图片
  void setErrorImage(String imagePath) {
    if (imagePath != null) {
      setState(() {
        _errImgPath = imagePath;
      });
    }
  }

  ///设置空页面图片
  void setEmptyImage(String imagePath) {
    if (imagePath != null) {
      setState(() {
        _emptyImgPath = imagePath;
      });
    }
  }
}

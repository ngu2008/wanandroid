import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanandroid_ngu/base/_base_widget.dart';
import 'package:wanandroid_ngu/http/api_service.dart';
import 'package:wanandroid_ngu/model/base_model.dart';
import 'package:wanandroid_ngu/model/collection_model.dart';
import 'package:wanandroid_ngu/ui/public_ui/webview_page.dart';

class CollectionsPage extends BaseWidget {
  @override
  BaseWidgetState<BaseWidget> getState() {
    return CollectionsPageState();
  }
}

class CollectionsPageState extends BaseWidgetState<CollectionsPage> {
  List<Collection> _datas = new List();
  ScrollController _scrollController = ScrollController(); //listview的控制器
  int _page = 0; //加载的页数

  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  Future<Null> getData() async {
    _page = 0;
    ApiService().getCollectionList((
      CollectionModel _collectionModel,
    ) {
      if (_collectionModel.errorCode==0) {//成功
        if (_collectionModel.data.datas.length > 0) {//有数据
          showContent();
          setState(() {
            _datas.clear();
            _datas.addAll(_collectionModel.data.datas);
          });
        } else {//数据为空
          showEmpty();
        }
      }else{
        Fluttertoast.showToast(msg: _collectionModel.errorMsg);
      }
    }, (DioError error) {//发生错误
      print(error.response);
      setState(() {
        showError();
      });
    }, _page);
  }

  Future<Null> _getMore() async {
    _page++;
    ApiService().getCollectionList((
      CollectionModel _collectionModel,
    ){
      if (_collectionModel.errorCode==0) {//成功
        showContent();
        if (_collectionModel.data.datas.length > 0) {//有数据
          setState(() {
            _datas.addAll(_collectionModel.data.datas);
          });
        } else {//数据为空
          Fluttertoast.showToast(msg:"没有更多数据了");
        }
      }else{
        Fluttertoast.showToast(msg: _collectionModel.errorMsg);
      }
    }, (DioError error) {
      print(error.response);
      setState(() {
        showError();
      });
    }, _page);
  }

  @override
  void initState() {
    super.initState();
    showloading();
    getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMore();
      }
    });
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
  }

  @override
  Widget getContentWidget(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          displacement: 15,
          child: ListView.separated(
            //普通项
            itemBuilder: _renderRow,
            //插入项
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: 0.5,
                color: Colors.black26,
              );
            },
            controller: _scrollController,
            itemCount: _datas.length + 1,
          ),
          onRefresh: getData),
      floatingActionButton: !showToTopBtn ? null : FloatingActionButton(
          child: Icon(Icons.arrow_upward),
          onPressed: () {
            //返回到顶部时执行动画
            _scrollController.animateTo(.0,
                duration: Duration(milliseconds: 200),
                curve: Curves.ease
            );
          }
      ),
    );
  }

  Future<Null> _cancelCollection(int _position, int _id, int _originId) async {
    ApiService().cancelCollection((BaseModel _baseModel) {
      if (_baseModel.errorCode == 0) {
        _datas.removeAt(_position);
      }
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: Text("移除成功！"),
      ));
      setState(() {});
    }, (DioError error) {
      print(error.response);
      setState(() {
        showError();
      });
    }, _id, _originId);
  }

  Widget _renderRow(BuildContext context, int index) {
    if (index < _datas.length) {
      return _itemView(context, index);
    }
    return null;
  }

  Widget _itemView(BuildContext context, int index) {
    return InkWell(
      child: _slideRow(index, _datas[index]),
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return new WebViewPage(
              title: _datas[index].title, url: _datas[index].link);
        }));
      },
    );
  }

  Widget _slideRow(int index, Collection item) {
    return new Slidable(
      delegate: new SlidableDrawerDelegate(),
      actionExtentRatio: 0.25,
      child: _newsRow(item),
      secondaryActions: <Widget>[
        new IconSlideAction(
          caption: '取消收藏',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            _cancelCollection(index, item.id, item.originId);
          },
        ),
      ],
    );
  }

  Widget _newsRow(Collection item) {
    return new Column(
      children: <Widget>[
        new Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "作者：" + item.author,
                  style: TextStyle(fontSize: 12),
                ),
                new Expanded(
                  child: new Text(
                    "收藏时间：" + item.niceDate,
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            )),
        Container(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3D4E5F),
                  ),
                  textAlign: TextAlign.left,
                ))
              ],
            )),
        Container(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Row(
              children: <Widget>[
                item.chapterName.isNotEmpty
                    ? Expanded(
                        child: Text(
                          "分类：" + item.chapterName,
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                    : Text("")
              ],
            )),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void onClickErrorWidget() {
    showloading();
    getData();
  }

  @override
  AppBar getAppBar() {
    return  AppBar(
      title: Text("我的收藏"),
      elevation: 0.4,
    );
  }
}

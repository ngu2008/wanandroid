import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanandroid_ngu/base/_base_widget.dart';
import 'package:wanandroid_ngu/common/application.dart';
import 'package:wanandroid_ngu/event/change_theme_event.dart';
import 'package:wanandroid_ngu/http/api_service.dart';
import 'package:wanandroid_ngu/model/wx_article_content_model.dart';
import 'package:wanandroid_ngu/model/wx_article_title_model.dart';
import 'package:wanandroid_ngu/ui/public_ui/webview_page.dart';
import 'package:wanandroid_ngu/util/theme_util.dart';

class PubliccPage extends BaseWidget {
  @override
  BaseWidgetState<BaseWidget> getState() {
    return PubliccPageState();
  }
}

class PubliccPageState extends BaseWidgetState<PubliccPage>
    with TickerProviderStateMixin {

  Color themeColor = ThemeUtils.currentColorTheme;

  List<WxArticleTitleData> _datas = new List();
  TabController _tabController;

  Future<Null> _getData() async {
    ApiService().getWxList((WxArticleTitleModel _articleTitleModel) {
      if (_articleTitleModel.errorCode == 0) {
        //成功
        if (_articleTitleModel.data.length > 0) {
          //有数据
          showContent();
          setState(() {
            _datas = _articleTitleModel.data;
          });
        } else {
          //数据为空
          showEmpty();
        }
      } else {
        Fluttertoast.showToast(msg: _articleTitleModel.errorMsg);
      }
    }, (DioError error) {
      //发生错误
      print(error.response);
      showError();
    });
  }

  @override
  void initState() {
    super.initState();
    setAppBarVisible(false);
    _getData();

    Application.eventBus.on<ChangeThemeEvent>().listen((event) {
      setState(() {
        themeColor = event.color;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  AppBar getAppBar() {
    return AppBar(
      title: Text("不显示"),
    );
  }

  @override
  Widget getContentWidget(BuildContext context) {
    _tabController = new TabController(
      vsync: this,
      length: _datas.length,
    );
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          color: themeColor,
          height: 48,
          child: TabBar(
            indicatorColor: Colors.white,
            labelStyle: TextStyle(fontSize: 16),
            unselectedLabelStyle: TextStyle(fontSize: 16),
            controller: _tabController,
            tabs: _datas.map((WxArticleTitleData item) {
              return Tab(text: item.name);
            }).toList(),
            isScrollable: true,
          ),
        ),
        Expanded(
            child: TabBarView(
          controller: _tabController,
          children: _datas.map((item) {
            return NewsList(item.id);
          }).toList(),
        ))
      ],
    ));
  }

  @override
  void onClickErrorWidget() {
    showloading();
    _getData();
  }
}

class NewsList extends StatefulWidget {
  final int id;
  NewsList(this.id);

  @override
  _NewsListState createState() {
    return new _NewsListState();
  }
}

class _NewsListState extends State<NewsList> {
  List<WxArticleContentDatas> _datas = new List();
  ScrollController _scrollController = ScrollController();
  int _page = 1;

  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  Future<Null> _getData() async {
    _page = 1;
    int _id = widget.id;
    ApiService().getWxArticleList(
        (WxArticleContentModel _wxArticleContentModel) {
      setState(() {
        _datas = _wxArticleContentModel.data.datas;
      });
    }, _id, _page);
  }

  Future<Null> _getMore() async {
    _page++;
    int _id = widget.id;
    ApiService().getWxArticleList((WxArticleContentModel _articleContentModel) {
      setState(() {
        _datas.addAll(_articleContentModel.data.datas);
      });
    }, _id, _page);
  }

  @override
  void initState() {
    super.initState();
    _getData();
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
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        displacement: 15,
        onRefresh: _getData,
        child: ListView.separated(
            physics: new AlwaysScrollableScrollPhysics(),
            itemBuilder: _renderRow,
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: 0.5,
                color: Colors.black26,
              );
            },
            controller: _scrollController,
            //包含加载更多
            itemCount: _datas.length + 1),
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

  Widget _renderRow(BuildContext context, int index) {
    if (index < _datas.length) {
      return new InkWell(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return new WebViewPage(
                title: _datas[index].title, url: _datas[index].link);
          }));
        },
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: <Widget>[
                  Text(
                    _datas[index].author,
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.left,
                  ),
                  Expanded(
                    child: Text(
                      _datas[index].niceDate,
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _datas[index].title,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3D4E5F),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _datas[index].superChapterName,
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
    return null;
  }
}

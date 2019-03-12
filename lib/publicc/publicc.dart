import 'package:flutter/material.dart';
import 'package:wanandroid_ngu/http/common_service.dart';
import 'package:wanandroid_ngu/model/wx_article_content_model.dart';
import 'package:wanandroid_ngu/model/wx_article_title_model.dart';
import 'package:wanandroid_ngu/public_ui/webview_page.dart';

class PubliccPage extends StatefulWidget {
  @override
  PubliccPageState createState() {
    return new PubliccPageState();
  }
}

class PubliccPageState extends State<PubliccPage>
    with TickerProviderStateMixin {

  List<WxArticleTitleData> _datas = new List();
  TabController _tabController;

  Future<Null> _getData() async {
    CommonService().getWxList((WxArticleTitleModel _articleTitleModel) {
      setState(() {
        _datas = _articleTitleModel.data;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabController = new TabController(
      vsync: this,
      length: _datas.length,
    );
    return Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: Text("公众号"),
          bottom: new TabBar(
            controller: _tabController,
            tabs: _datas.map((WxArticleTitleData item) {
              return Tab(text: item.name);
            }).toList(),
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _datas.map((item) {
            return NewsList(item.id);
          }).toList(),
        ));
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
    CommonService().getWxArticleList(
        (WxArticleContentModel _wxArticleContentModel) {
      setState(() {
        _datas = _wxArticleContentModel.data.datas;
      });
    }, _id, _page);
  }

  Future<Null> _getMore() async {
    _page++;
    int _id = widget.id;
    CommonService().getWxArticleList(
        (WxArticleContentModel _articleContentModel) {
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
                    _datas[index ].author,
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

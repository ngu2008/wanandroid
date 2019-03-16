import 'package:flutter/material.dart';
import 'package:wanandroid_ngu/http/common_service.dart';
import 'package:wanandroid_ngu/model/system_tree_content_model.dart';
import 'package:wanandroid_ngu/model/system_tree_model.dart';
import 'package:wanandroid_ngu/public_ui/webview_page.dart';

class KnowledgeContentPage extends StatefulWidget {
  SystemTreeData data;

  KnowledgeContentPage(ValueKey<SystemTreeData> key) : super(key: key) {
    this.data = key.value;
  }

  @override
  State<StatefulWidget> createState() {
    return KnowledgeContentPageState();
  }
}

class KnowledgeContentPageState extends State<KnowledgeContentPage>
    with TickerProviderStateMixin {
  SystemTreeData _datas;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _datas = widget.data;
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabController =
        new TabController(length: _datas.children.length, vsync: this);
    return new Scaffold(
      appBar: new AppBar(
        title: Text(_datas.name),
        bottom: new TabBar(
          controller: _tabController,
            isScrollable: true,
            tabs: _datas.children.map((SystemTreeChild item) {
              return Tab(
                text: item.name,
              );
            }).toList()),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _datas.children.map((item) {
          return NewsList(
            id: item.id,
          );
        }).toList(),
      ),
    );
  }
}

//知识体系文章列表
class NewsList extends StatefulWidget {
  final int id; //知识体系id
  @override
  NewsList({Key key, this.id}) : super(key: key);

  _NewsListState createState() => new _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List<SystemTreeContentChild> _datas = new List();
  ScrollController _scrollController = ScrollController(); //listview的控制器
  int _page = 0;

  @override
  void initState() {
    super.initState();
    getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMore();
      }
    });
  }

  Future<Null> getData() async {
    _page = 0;
    int _id = widget.id;
    CommonService().getSystemTreeContent(
        (SystemTreeContentModel _systemTreeContentModel) {
      setState(() {
        _datas = _systemTreeContentModel.data.datas;
      });
    }, _page, _id);
  }

  Future<Null> _getMore() async {
    _page++;
    int _id = widget.id;

    CommonService().getSystemTreeContent(
        (SystemTreeContentModel _systemTreeContentModel) {
      setState(() {
        _datas.addAll(_systemTreeContentModel.data.datas);
      });
    }, _page, _id);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: RefreshIndicator(
        onRefresh: getData,
        child: ListView.separated(
          physics: new AlwaysScrollableScrollPhysics(),
          itemBuilder: _renderRow,
          itemCount: _datas.length + 1,
          controller: _scrollController,
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 0.5,
              color: Colors.black26,
            );
          },
        ),
      ),
    );
  } //加载的页数

  Widget _renderRow(BuildContext context, int index) {
    if(index<_datas.length){
      return  InkWell(
        child: Container(
          child:  _newsRow(_datas[index]),
        ),
        onTap: (){
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return new WebViewPage(
                title: _datas[index].title, url: _datas[index].link);
          }));
        },
      );
    }
    return null;
  }

  //新闻列表单个item
  Widget _newsRow(SystemTreeContentChild item) {
    return new Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          new Container(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    item.author,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  new Expanded(
                    child: new Text(
                      item.niceDate,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              )),
          Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                        item.title,
                        style: TextStyle(fontSize: 16, color: const Color(0xFF3D4E5F),fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ))
                ],
              )),
          Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Row(
                children: <Widget>[
                  Text(
                    item.superChapterName,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  new Text(
                    "/" + item.chapterName,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.right,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

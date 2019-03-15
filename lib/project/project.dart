import 'package:flutter/material.dart';
import 'package:wanandroid_ngu/http/common_service.dart';
import 'package:wanandroid_ngu/model/projectlist_model.dart';
import 'package:wanandroid_ngu/model/project_tree_model.dart';
import 'package:wanandroid_ngu/public_ui/webview_page.dart';

class ProjectPage extends StatefulWidget {
  @override
  ProjectPageState createState() {
    return new ProjectPageState();
  }
}

class ProjectPageState extends State<ProjectPage>
    with TickerProviderStateMixin {
  List<ProjectTreeData> _datas = new List();
  TabController _tabController;

  Future<Null> _getData() async {
    CommonService().getProjectTree((ProjectTreeModel _projectTreeModel) {
      setState(() {
        _datas = _projectTreeModel.data;
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
        body: Column(
          children: <Widget>[
            Container(
              color: const Color(0xFF5394FF),
              height: 48,
              child: TabBar(
                labelStyle:TextStyle(fontSize: 16),
                unselectedLabelStyle: TextStyle(fontSize: 16),
                controller: _tabController,
                tabs: _datas.map((ProjectTreeData item) {
                  return Tab(text: item.name);
                }).toList(),
                isScrollable: true,
              ),
            ),
            Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: _datas.map((item) {
                    return ProjectList(item.id);
                  }).toList(),
                ))
          ],
        ));
  }
}

class ProjectList extends StatefulWidget {
  final int id;

  ProjectList(this.id);

  @override
  _ProjectListState createState() {
    return new _ProjectListState();
  }
}

class _ProjectListState extends State<ProjectList> {
  List<ProjectTreeListDatas> _datas = new List();
  ScrollController _scrollController = ScrollController();
  int _page = 1;

  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  Future<Null> _getData() async {
    _page = 1;
    int _id = widget.id;
    CommonService().getProjectList((ProjectTreeListModel projectTreeListModel) {
      setState(() {
        _datas = projectTreeListModel.data.datas;
      });
    }, _page, _id);
  }

  Future<Null> _getMore() async {
    _page++;
    int _id = widget.id;
    CommonService().getProjectList((ProjectTreeListModel projectTreeListModel) {
      setState(() {
        _datas.addAll(projectTreeListModel.data.datas);
      });
    }, _page, _id);
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
            itemBuilder: _renderRow,
            physics: new AlwaysScrollableScrollPhysics(),
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
        child: Container(
          color: Colors.white,
          child:   Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
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
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              _datas[index].desc,
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                              textAlign: TextAlign.left,
                              maxLines: 3,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            _datas[index].author,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(
                            _datas[index].niceDate,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
                  child: Image.network(
                    _datas[index].envelopePic,
                    width: 80,
                    height: 120,
                    fit: BoxFit.fill,
                  )),
            ],
          ) ,
        ),
      );
    }
    return null;
  }
}

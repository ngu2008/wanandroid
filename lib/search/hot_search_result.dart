import 'package:flutter/material.dart';
import 'package:wanandroid_ngu/http/common_service.dart';
import 'package:wanandroid_ngu/model/hotword_result_model.dart';
import 'package:wanandroid_ngu/public_ui/webview_page.dart';

class HotResultPage extends StatefulWidget {
  String hot;
  HotResultPage(this.hot);

  @override
  State<StatefulWidget> createState() {
    return HotResultPageState();
  }
}

class HotResultPageState extends State<HotResultPage>{

  List<DatasListBean> _datas = new List();
  ScrollController _scrollController = ScrollController();
  int _page = 0;

  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  Future<Null> _getData() async {
    _page = 0;
    String  _keyword = widget.hot;
    CommonService().getSearchResult((HotwordResultModel otwordResultModel) {
      setState(() {
        _datas.clear();
        _datas.addAll(otwordResultModel.data.datas);
      });
    }, _page, _keyword);
  }

  Future<Null> _getMore() async {
    _page++;
    String  _keyword = widget.hot;
    CommonService().getSearchResult((HotwordResultModel otwordResultModel) {
      setState(() {
        _datas.addAll(otwordResultModel.data.datas);
      });
    }, _page, _keyword);
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
       appBar: AppBar(
         title: Text(widget.hot),
       ),
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
    );;
  }

  Widget _renderRow(BuildContext context, int index) {
    if (index < _datas.length) {
      return new InkWell(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return new WebViewPage(
                title: _datas[index].title.replaceAll("<em class='highlight'>", "")
                    .replaceAll("<\/em>", ""), url: _datas[index].link);
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
                      _datas[index].title .replaceAll("<em class='highlight'>", "")
                  .replaceAll("<\/em>", ""),
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

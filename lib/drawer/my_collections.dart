import 'package:flutter/material.dart';
import 'package:wanandroid_ngu/http/common_service.dart';
import 'package:wanandroid_ngu/model/base_model.dart';
import 'package:wanandroid_ngu/model/collection_model.dart';
import 'package:wanandroid_ngu/public_ui/webview_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyCollections extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的收藏"),
        centerTitle: true,
        elevation: 0.4,
      ),
      body: CollectionList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {},
        tooltip: "收藏",
        child: new Icon(Icons.add),
      ),
    );
  }
}

class CollectionList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _NewsListState();
  }
}

class _NewsListState extends State<CollectionList> {
  List<Collection> _datas = new List();
  ScrollController _scrollController = ScrollController(); //listview的控制器
  int _page = 0; //加载的页数

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
    CommonService().getCollectionList((CollectionModel _collectionModel) {
      setState(() {
        _datas.clear();
        _datas.addAll(_collectionModel.data.datas);
      });
    }, _page);
  }

  Future<Null> _getMore() async {
    _page++;
    CommonService().getCollectionList((CollectionModel _collectionModel) {
      setState(() {
        _datas.addAll(_collectionModel.data.datas);
      });
    }, _page);
  }

  Future<Null> _cancelCollection(int _position, int _id, int _originId) async {
    CommonService().cancelCollection((BaseModel _baseModel) {
      if (_baseModel.errorCode == 0) {
        _datas.removeAt(_position);
      }
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: Text("移除成功！"),
      ));
      setState(() {});
    }, _id, _originId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
          child: ListView.separated(
            itemBuilder: _renderRow,
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
    );
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
        Navigator.of(context).push(new MaterialPageRoute(builder: (context){
          return new WebViewPage(title: _datas[index].title,url: _datas[index].link);
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
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,  color: const Color(0xFF3D4E5F),),
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

}

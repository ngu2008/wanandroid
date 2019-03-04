import 'package:flutter/material.dart';
import 'package:wanandroid_ngu/http/common_service.dart';
import 'package:wanandroid_ngu/knowledge/knowledge_content.dart';
import 'package:wanandroid_ngu/model/SystemTreeModel.dart';
import 'package:wanandroid_ngu/public_ui/webview_page.dart';
import 'package:wanandroid_ngu/util/utils.dart';

class KnowledgePage extends StatefulWidget {
  @override
  KnowledgePageState createState() {
    return new KnowledgePageState();
  }
}

class KnowledgePageState extends State<KnowledgePage> {

  List<SystemTreeData> _datas = new List();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<Null> _getData() async {
    CommonService().getSystemTree((SystemTreeModel _systemTreeModel){
      setState(() {
        _datas=_systemTreeModel.data;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
            itemCount: _datas.length),
      ),
    );
  }

  Widget _renderRow(BuildContext context, int index) {
    if (index < _datas.length) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return new KnowledgeContentPage(new ValueKey(_datas[index]));
          }));
        },
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            _datas[index].name,
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF3D4E5F),
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: buildChildren(_datas[index].children)),
                      ],
                    ),
                  )),
              Icon(Icons.chevron_right)
            ],
          ),
        )
      );
    }
    return null;
  }

  Widget buildChildren(List<SystemTreeChild> children) {
    List<Widget> tiles = []; //先建一个数组用于存放循环生成的widget
    Widget content; //单独一个widget组件，用于返回需要生成的内容widget
    for (var item in children) {
      tiles.add(
        new Chip(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: Utils.getChipBgColor(item.name),
          label: new Text(item.name),
//          avatar: new CircleAvatar(backgroundColor: Colors.blue,child: Text("A"),),
        ),
      );
    }

    content = Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.start,
        children: tiles);

    return content;
  }

}

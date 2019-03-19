import 'package:flutter/material.dart';
import 'package:wanandroid_ngu/http/api_service.dart';
import 'package:wanandroid_ngu/model/hotword_model.dart';
import 'package:wanandroid_ngu/ui/search/hot_search_result.dart';
import 'package:wanandroid_ngu/util/utils.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {
  TextEditingController editingController;
  FocusNode focusNode = new FocusNode();
  List<Widget> actions = new List();
  List<DataListBean> _datas = new List();

  String search;

  @override
  void initState() {
    super.initState();

    editingController = new TextEditingController(text: search);
    editingController.addListener(() {
      if (editingController.text == null || editingController.text == "") {
        setState(() {
          actions = [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  changeContent();
                })
          ];
        });
      } else {
        setState(() {
          actions = [
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  editingController.clear();
                  changeContent();
                }),
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  changeContent();
                })
          ];
        });
      }
    });
    _getData();
  }

  //获取文章列表数据
  Future<Null> _getData() async {
    ApiService().getSearchHotWord((HotwordModel hotwordModel) {
      setState(() {
        _datas = hotwordModel.data;
      });
    });
  }

  void changeContent() {
    focusNode.unfocus();
    setState(() {});
    if (editingController.text == null || editingController.text == "") {

    }else{
      Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
        return new HotResultPage(editingController.text);
      }));
    }

  }

  @override
  Widget build(BuildContext context) {
    TextField searchField = new TextField(
      autofocus: true,
      style: TextStyle(color: Colors.white),
      decoration: new InputDecoration(
          hintStyle: TextStyle(color: Colors.white),
          border: InputBorder.none,
          hintText: "搜索更多干货"),
      focusNode: focusNode,
      controller: editingController,
    );

    return Scaffold(
      appBar: AppBar(
        title: searchField,
        actions: actions,
      ),
      body: buildChildren(_datas),
    );
  }

  Widget buildChildren(List<DataListBean> children) {
    List<Widget> names = []; //先建一个数组用于存放循环生成的widget
    Widget content; //单独一个widg

    for (DataListBean item in children) {
      names.add(new InkWell(
        child: new Chip(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: Utils.getChipBgColor(item.name),
            label: new Text(item.name)),
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return new HotResultPage(item.name);
          }));
        },
      ));
    }
    content = Padding(
        padding: EdgeInsets.only(left: 20),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.start,
          children: names,
        ));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            "热门搜索",
            style: TextStyle(color: const Color(0xFF5394FF), fontSize: 18),
          ),
        ),
        content,
      ],
    );
  }
}

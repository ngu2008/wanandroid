import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid_ngu/http/common_service.dart';
import 'package:wanandroid_ngu/model/common_websit_model.dart';
import 'package:wanandroid_ngu/model/projectlist_model.dart';
import 'package:wanandroid_ngu/public_ui/webview_page.dart';
import 'package:wanandroid_ngu/util/utils.dart';

class CommonWebsitePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new CommonWebsitePageState();
  }
}

class CommonWebsitePageState extends State<CommonWebsitePage> {
  List<DataListBean> _datas = new List();
  ScrollController _scrollController = ScrollController();

  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  Future<Null> _getData() async {
    CommonService().getCommonWebsite((CommonWebsitModel commonWebsitModel) {
      setState(() {
        _datas = commonWebsitModel.data;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("常用网站"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _getData,
        child: GridView.builder(
          padding: EdgeInsets.all(15),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //每行2列
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 1.333 //

                ),
            controller: _scrollController,
            itemCount: _datas.length,
            itemBuilder: _renderItem),
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

  Color _getColor(int index) {
    switch (index % 8) {
      case 0:
        return const Color(0xFFfb6e52);
      case 1:
        return const Color(0xFFa1d46f);
      case 2:
        return const Color(0xFF5cc0e2);
      case 3:
        return const Color(0xFFffbb44);
      case 4:
        return const Color(0xFFef6666);
      case 5:
        return const Color(0xFFf8d19e);
      case 6:
        return const Color(0xFF48cfae);
      case 7:
        return const Color(0xFFaa9ef8);
    }
  }

  Widget _renderItem(BuildContext context, int index) {
    return new InkWell(
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return new WebViewPage(
              title: _datas[index].name, url: _datas[index].link);
        }));
      },
      child: Container(
        padding: EdgeInsets.only(top: 25,left: 25),
        color: _getColor(index),
        child:Text(_datas[index].name,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanandroid_ngu/base/_base_widget.dart';
import 'package:wanandroid_ngu/db/db_helper.dart';
import 'package:wanandroid_ngu/http/api_service.dart';
import 'package:wanandroid_ngu/model/common_websit_model.dart';
import 'package:wanandroid_ngu/ui/public_ui/webview_page.dart';

class CommonWebsitePage extends BaseWidget {
  @override
  BaseWidgetState<BaseWidget> getState() {
    return CommonWebsitePageState();
  }
}

class CommonWebsitePageState extends BaseWidgetState<CommonWebsitePage> {
  List<DataListBean> _datas = new List();
  ScrollController _scrollController = ScrollController();
  var db = DatabaseHelper();

  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  Future<Null> _getData() async {
    ApiService().getCommonWebsite((CommonWebsitModel commonWebsitModel) {
      if (commonWebsitModel.errorCode == 0) {
        var datas = commonWebsitModel.data;
        if (datas != null && datas.length > 0) {
          showContent();
          setState(() {
            _datas = datas;
          });
          //清空表数据
          db.clear();
          //数据存入数据库
          for (int i = 0; i < datas.length; i++) {
            db.saveItem(datas[i]);
          }
        } else {
          showEmpty();
        }
      } else {
        Fluttertoast.showToast(msg: commonWebsitModel.errorMsg);
      }
    }, (DioError error) {
      //发生错误
      print(error.response);
//      setState(() {
//        showError();
//      });
    });
  }

  _getDataFromDb() async {
    List datas = await db.getTotalList();
    if (datas.length > 0) {
      datas.forEach((item) {
        DataListBean dataListBean = DataListBean.fromMap(item);
        _datas.add(dataListBean);
      });
      setState(() {

      });
    } else {
      showloading();
    }
  }

  @override
  void initState() {
    super.initState();
    // showloading();
    //读取数据库的数据
    _getDataFromDb();

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

  Widget _getBodyWidget(List<DataListBean> datas) {
    return RefreshIndicator(
      displacement: 15,
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
        padding: EdgeInsets.only(top: 25, left: 25),
        color: _getColor(index),
        child: Text(
          _datas[index].name,
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  AppBar getAppBar() {
    return AppBar(
      title: Text("常用网站"),
      elevation: 0.4,
    );
  }

  @override
  Widget getContentWidget(BuildContext context) {
    return Scaffold(
      body: _getBodyWidget(_datas),
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

  @override
  void onClickErrorWidget() {
    showloading();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

}

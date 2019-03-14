import 'package:dio/dio.dart';
import 'package:wanandroid_ngu/common/user.dart';
import 'package:wanandroid_ngu/http/dio_manager.dart';
import 'package:wanandroid_ngu/model/article_model.dart';
import 'package:wanandroid_ngu/model/banner_model.dart';
import 'package:wanandroid_ngu/model/base_model.dart';
import 'package:wanandroid_ngu/model/collection_model.dart';
import 'package:wanandroid_ngu/model/common_websit_model.dart';
import 'package:wanandroid_ngu/model/hotword_model.dart';
import 'package:wanandroid_ngu/model/navi_model.dart';
import 'package:wanandroid_ngu/model/projectlist_model.dart';
import 'package:wanandroid_ngu/model/project_tree_model.dart';
import 'package:wanandroid_ngu/model/system_tree_content_model.dart';
import 'package:wanandroid_ngu/model/system_tree_model.dart';
import 'package:wanandroid_ngu/model/todolist_model.dart';
import 'package:wanandroid_ngu/model/user_model.dart';
import 'package:wanandroid_ngu/model/website_collection_model.dart';
import 'package:wanandroid_ngu/model/wx_article_content_model.dart';
import 'package:wanandroid_ngu/model/wx_article_title_model.dart';

import 'api.dart';

class CommonService{
  void getBanner(Function callback) async {
    DioManager.singleton.dio.get(Api.HOME_BANNER, options: _getOptions()).then((response) {
      callback(BannerModel(response.data));
    });
  }
  void getArticleList(Function callback,int _page) async {
    DioManager.singleton.dio.get(Api.HOME_ARTICLE_LIST+"$_page/json", options: _getOptions()).then((response) {
      callback(ArticleModel(response.data));
    });
  }

  void getArticleList2(Function callback,int _page) async {
    DioManager.singleton.dio.get("http://www.wanandroid.com/lg/collect/list/0/json", options: _getOptions()).then((response) {
      callback(ArticleModel(response.data));
    });
  }
  
  /// 获取知识体系列表
  void getSystemTree(Function callback) async {
    DioManager.singleton.dio.get(Api.SYSTEM_TREE, options: _getOptions()).then((response) {
      callback(SystemTreeModel(response.data));
    });
  }
  /// 获取知识体系列表详情
  void getSystemTreeContent(Function callback,int _page,int _id) async {
    DioManager.singleton.dio.get(Api.SYSTEM_TREE_CONTENT+"$_page/json?cid=$_id", options: _getOptions()).then((response) {
      callback(SystemTreeContentModel(response.data));
    });
  }
  /// 获取公众号名称
  void getWxList(Function callback) async {
    DioManager.singleton.dio.get(Api.WX_LIST, options: _getOptions()).then((response) {
      callback(WxArticleTitleModel(response.data));
    });
  }
  /// 获取公众号文章
  void getWxArticleList(Function callback,int _id,int _page) async {
    DioManager.singleton.dio.get(Api.WX_ARTICLE_LIST+"$_id/$_page/json", options: _getOptions()).then((response) {
      callback(WxArticleContentModel(response.data));
    });
  }
  /// 获取导航列表数据
  void getNaviList(Function callback) async {
    DioManager.singleton.dio.get(Api.NAVI_LIST, options: _getOptions()).then((response) {
      callback(NaviModel(response.data));
    });
  }
  /// 获取项目分类
  void getProjectTree(Function callback) async {
    DioManager.singleton.dio.get(Api.PROJECT_TREE, options: _getOptions()).then((response) {
      callback(ProjectTreeModel(response.data));
    });
  }
  /// 获取项目列表
  void getProjectList(Function callback,int _page,int _id) async {
    DioManager.singleton.dio.get(Api.PROJECT_LIST+"$_page/json?cid=$_id", options: _getOptions()).then((response) {
      callback(ProjectTreeListModel(response.data));
    });
  }
  /// 获取搜索热词
  void getSearchHotWord(Function callback) async {
    DioManager.singleton.dio.get(Api.SEARCH_HOT_WORD, options: _getOptions()).then((response) {
      callback(HotWordModel(response.data));
    });
  }
  /// 获取搜索结果
  void getSearchResult(Function callback,int _page,String _id) async {
    FormData formData = new FormData.from({
      "k": _id,
    });
    DioManager.singleton.dio.post(Api.SEARCH_RESULT+"$_page/json", data: formData, options: _getOptions()).then((response) {
      callback(ArticleModel(response.data));
    });
  }

  /// 登录
  void login(Function callback,String _username,String _password) async {
    FormData formData = new FormData.from({
      "username": _username,
      "password":_password
    });
    DioManager.singleton.dio.post(Api.USER_LOGIN, data: formData, options: _getOptions()).then((response) {
      callback(UserModel(response.data),response);
    });
  }

  /// 注册
  void register(Function callback,String _username,String _password) async {
    FormData formData = new FormData.from({
      "username": _username,
      "password":_password,
      "repassword":_password
    });
    DioManager.singleton.dio.post(Api.USER_REGISTER, data: formData, options: null).then((response) {
      print(response.toString());
      callback(UserModel(response.data));
    });
  }

  /// 获取收藏列表
  void getCollectionList(Function callback,int _page) async {
    DioManager.singleton.dio.get(Api.COLLECTION_LIST+"$_page/json", options: _getOptions()).then((response) {
      callback(CollectionModel(response.data));
    });
  }

  /// 我的收藏-取消收藏
  void cancelCollection(Function callback,int _id,int _originId) async {
     FormData formData = new FormData.from({
      "originId": _originId
    });
    DioManager.singleton.dio.post(Api.CANCEL_COLLECTION+"$_id/json", data: formData,options: _getOptions()).then((response) {
      callback(BaseModel(response.data));
    });
  }
  /// 我的收藏-新增收藏
  void addCollection(Function callback,String _title,String _author,String _link) async {
     FormData formData = new FormData.from({
      "title": _title,
      "author":_author,
      "link":_link
    });
    DioManager.singleton.dio.post(Api.ADD_COLLECTION, data: formData,options: _getOptions()).then((response) {
      callback(BaseModel(response.data));
    });
  }

  /// 网站收藏列表
  void getWebsiteCollectionList(Function callback) async {
    DioManager.singleton.dio.get(Api.WEBSITE_COLLECTION_LIST, options: _getOptions()).then((response) {
      callback(WebsiteCollectionModel(response.data));
    });
  }

  ///常用网站
  void getCommonWebsite(Function callback) async{
    DioManager.singleton.dio.get(Api.COMMON_WEBSITE,options:_getOptions()).then((response){
      callback(CommonWebsitModel.fromMap(response.data));
    });

  }





  /// 取消网站收藏
  void cancelWebsiteCollectionList(Function callback,int _id) async {
    FormData formData = new FormData.from({
      "id": _id,
    });
    DioManager.singleton.dio.post(Api.CANCEL_WEBSITE_COLLECTION, data: formData, options: _getOptions()).then((response) {
      callback(BaseModel(response.data));
    });
  }
  /// 新增网站收藏
  void addWebsiteCollectionList(Function callback,String _name,String _link) async {
    FormData formData = new FormData.from({
      "name": _name,
      "link":_link
    });
    DioManager.singleton.dio.post(Api.ADD_WEBSITE_COLLECTION, data: formData, options: _getOptions()).then((response) {
      callback(BaseModel(response.data));
    });
  }
  /// 编辑网站收藏
  void editWebsiteCollectionList(Function callback,int _id,String _name,String _link) async {
    FormData formData = new FormData.from({
      "id": _id,
      "name": _name,
      "link":_link
    });
    DioManager.singleton.dio.post(Api.EDIT_WEBSITE_COLLECTION, data: formData, options: _getOptions()).then((response) {
      callback(BaseModel(response.data));
    });
  }

  /// todo列表
  void getTodoList(Function callback,int _type) async {
    DioManager.singleton.dio.get(Api.TODO_LIST+"$_type/json", options: _getOptions()).then((response) {
      callback(TodoListModel(response.data));
    });
  }
  
  /// 新增todo数据
  void addTodoData(Function callback,String _title,String _content,String _date,int _type) async {
    FormData formData = new FormData.from({
      "title": _title,
      "content": _content,
      "date":_date,
      "type":_type
    });
    DioManager.singleton.dio.post(Api.ADD_TODO, data: formData, options: _getOptions()).then((response) {
      callback(BaseModel(response.data));
    });
  }

  /// 更新todo数据
  void updateTodoData(Function callback,int _id,String _title,String _content,String _date,int _status,int _type) async {
    FormData formData = new FormData.from({
      "title": _title,
      "content": _content,
      "date":_date,
      "status":_status,
      "type":_type
    });
    DioManager.singleton.dio.post(Api.UPDATE_TODO+"$_id/json", data: formData, options: _getOptions()).then((response) {
      callback(BaseModel(response.data));
    });
  }


  /// 删除todo数据
  void deleteTodoData(Function callback,int _id) async {
    DioManager.singleton.dio.post(Api.DELETE_TODO+"$_id/json", data: null, options: _getOptions()).then((response) {
      callback(BaseModel(response.data));
    });
  }
  
  /// 仅更新todo完成状态
  void doneTodoData(Function callback,int _id,int _status) async {
    FormData formData = new FormData.from({
      "status":_status
    });
    DioManager.singleton.dio.post(Api.DONE_TODO+"$_id/json", data: formData, options: _getOptions()).then((response) {
      callback(BaseModel(response.data));
    });
  }

  Options _getOptions() {
    Map<String,String> map = new Map();
    List<String> cookies = User().cookie;
    map["Cookie"] = cookies.toString();
    return Options(headers: map);
  }
}
import 'dart:convert' show json;

class WxArticleTitleModel {

  int errorCode;
  String errorMsg;
  List<WxArticleTitleData> data;

  WxArticleTitleModel.fromParams({this.errorCode, this.errorMsg, this.data});

  factory WxArticleTitleModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new WxArticleTitleModel.fromJson(json.decode(jsonStr)) : new WxArticleTitleModel.fromJson(jsonStr);

  WxArticleTitleModel.fromJson(jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
      data.add(dataItem == null ? null : new WxArticleTitleData.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"errorCode": $errorCode,"errorMsg": ${errorMsg != null?'${json.encode(errorMsg)}':'null'},"data": $data}';
  }
}

class WxArticleTitleData {

  int courseId;
  int id;
  int order;
  int parentChapterId;
  int visible;
  bool userControlSetTop;
  String name;
  List<dynamic> children;

  WxArticleTitleData.fromParams({this.courseId, this.id, this.order, this.parentChapterId, this.visible, this.userControlSetTop, this.name, this.children});

  WxArticleTitleData.fromJson(jsonRes) {
    courseId = jsonRes['courseId'];
    id = jsonRes['id'];
    order = jsonRes['order'];
    parentChapterId = jsonRes['parentChapterId'];
    visible = jsonRes['visible'];
    userControlSetTop = jsonRes['userControlSetTop'];
    name = jsonRes['name'];
    children = jsonRes['children'] == null ? null : [];

    for (var childrenItem in children == null ? [] : jsonRes['children']){
      children.add(childrenItem);
    }
  }

  @override
  String toString() {
    return '{"courseId": $courseId,"id": $id,"order": $order,"parentChapterId": $parentChapterId,"visible": $visible,"userControlSetTop": $userControlSetTop,"name": ${name != null?'${json.encode(name)}':'null'},"children": $children}';
  }
}


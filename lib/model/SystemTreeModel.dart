import 'dart:convert' show json;

class SystemTreeModel {

  int errorCode;
  String errorMsg;
  List<SystemTreeData> data;

  SystemTreeModel.fromParams({this.errorCode, this.errorMsg, this.data});

  factory SystemTreeModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new SystemTreeModel.fromJson(json.decode(jsonStr)) : new SystemTreeModel.fromJson(jsonStr);

  SystemTreeModel.fromJson(jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
      data.add(dataItem == null ? null : new SystemTreeData.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"errorCode": $errorCode,"errorMsg": ${errorMsg != null?'${json.encode(errorMsg)}':'null'},"data": $data}';
  }
}

class SystemTreeData {

  int courseId;
  int id;
  int order;
  int parentChapterId;
  int visible;
  bool userControlSetTop;
  String name;
  List<SystemTreeChild> children;

  SystemTreeData.fromParams({this.courseId, this.id, this.order, this.parentChapterId, this.visible, this.userControlSetTop, this.name, this.children});

  SystemTreeData.fromJson(jsonRes) {
    courseId = jsonRes['courseId'];
    id = jsonRes['id'];
    order = jsonRes['order'];
    parentChapterId = jsonRes['parentChapterId'];
    visible = jsonRes['visible'];
    userControlSetTop = jsonRes['userControlSetTop'];
    name = jsonRes['name'];
    children = jsonRes['children'] == null ? null : [];

    for (var childrenItem in children == null ? [] : jsonRes['children']){
      children.add(childrenItem == null ? null : new SystemTreeChild.fromJson(childrenItem));
    }
  }

  @override
  String toString() {
    return '{"courseId": $courseId,"id": $id,"order": $order,"parentChapterId": $parentChapterId,"visible": $visible,"userControlSetTop": $userControlSetTop,"name": ${name != null?'${json.encode(name)}':'null'},"children": $children}';
  }
}

class SystemTreeChild {

  int courseId;
  int id;
  int order;
  int parentChapterId;
  int visible;
  bool userControlSetTop;
  String name;
  List<dynamic> children;

  SystemTreeChild.fromParams({this.courseId, this.id, this.order, this.parentChapterId, this.visible, this.userControlSetTop, this.name, this.children});

  SystemTreeChild.fromJson(jsonRes) {
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


import 'dart:convert' show json;

class WebsiteCollectionModel {

  int errorCode;
  String errorMsg;
  List<WebsiteCollectionData> data;

  WebsiteCollectionModel.fromParams({this.errorCode, this.errorMsg, this.data});

  factory WebsiteCollectionModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new WebsiteCollectionModel.fromJson(json.decode(jsonStr)) : new WebsiteCollectionModel.fromJson(jsonStr);
  
  WebsiteCollectionModel.fromJson(jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
            data.add(dataItem == null ? null : new WebsiteCollectionData.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"errorCode": $errorCode,"errorMsg": ${errorMsg != null?'${json.encode(errorMsg)}':'null'},"data": $data}';
  }
}

class WebsiteCollectionData {

  int id;
  int order;
  int userId;
  int visible;
  String desc;
  String icon;
  String link;
  String name;

  WebsiteCollectionData.fromParams({this.id, this.order, this.userId, this.visible, this.desc, this.icon, this.link, this.name});
  
  WebsiteCollectionData.fromJson(jsonRes) {
    id = jsonRes['id'];
    order = jsonRes['order'];
    userId = jsonRes['userId'];
    visible = jsonRes['visible'];
    desc = jsonRes['desc'];
    icon = jsonRes['icon'];
    link = jsonRes['link'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"id": $id,"order": $order,"userId": $userId,"visible": $visible,"desc": ${desc != null?'${json.encode(desc)}':'null'},"icon": ${icon != null?'${json.encode(icon)}':'null'},"link": ${link != null?'${json.encode(link)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'}}';
  }
}


import 'dart:convert' show json;

class CommonWebsiteModel {

  int errorCode;
  String errorMsg;
  List<CommonWebsiteData> data;

  CommonWebsiteModel.fromParams({this.errorCode, this.errorMsg, this.data});

  factory CommonWebsiteModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new CommonWebsiteModel.fromJson(json.decode(jsonStr)) : new CommonWebsiteModel.fromJson(jsonStr);

  CommonWebsiteModel.fromJson(jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
      data.add(dataItem == null ? null : new CommonWebsiteData.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"errorCode": $errorCode,"errorMsg": ${errorMsg != null?'${json.encode(errorMsg)}':'null'},"data": $data}';
  }
}

class CommonWebsiteData {

  int id;
  int order;
  int visible;
  String icon;
  String link;
  String name;

  CommonWebsiteData.fromParams({this.id, this.order, this.visible, this.icon, this.link, this.name});

  CommonWebsiteData.fromJson(jsonRes) {
    id = jsonRes['id'];
    order = jsonRes['order'];
    visible = jsonRes['visible'];
    icon = jsonRes['icon'];
    link = jsonRes['link'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"id": $id,"order": $order,"visible": $visible,"icon": ${icon != null?'${json.encode(icon)}':'null'},"link": ${link != null?'${json.encode(link)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'}}';
  }
}


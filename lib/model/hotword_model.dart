import 'dart:convert' show json;

class HotWordModel {

  int errorCode;
  String errorMsg;
  List<HotWordData> data;

  HotWordModel.fromParams({this.errorCode, this.errorMsg, this.data});

  factory HotWordModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new HotWordModel.fromJson(json.decode(jsonStr)) : new HotWordModel.fromJson(jsonStr);

  HotWordModel.fromJson(jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
      data.add(dataItem == null ? null : new HotWordData.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"errorCode": $errorCode,"errorMsg": ${errorMsg != null?'${json.encode(errorMsg)}':'null'},"data": $data}';
  }
}

class HotWordData {

  int id;
  int order;
  int visible;
  String link;
  String name;

  HotWordData.fromParams({this.id, this.order, this.visible, this.link, this.name});

  HotWordData.fromJson(jsonRes) {
    id = jsonRes['id'];
    order = jsonRes['order'];
    visible = jsonRes['visible'];
    link = jsonRes['link'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"id": $id,"order": $order,"visible": $visible,"link": ${link != null?'${json.encode(link)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'}}';
  }
}


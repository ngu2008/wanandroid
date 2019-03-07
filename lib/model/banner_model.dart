import 'dart:convert' show json;

class BannerModel {

  int errorCode;
  String errorMsg;
  List<BannerData> data;

  BannerModel.fromParams({this.errorCode, this.errorMsg, this.data});

  factory BannerModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new BannerModel.fromJson(json.decode(jsonStr)) : new BannerModel.fromJson(jsonStr);

  BannerModel.fromJson(jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
      data.add(dataItem == null ? null : new BannerData.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"errorCode": $errorCode,"errorMsg": ${errorMsg != null?'${json.encode(errorMsg)}':'null'},"data": $data}';
  }
}

class BannerData {

  int id;
  int isVisible;
  int order;
  int type;
  String desc;
  String imagePath;
  String title;
  String url;

  BannerData.fromParams({this.id, this.isVisible, this.order, this.type, this.desc, this.imagePath, this.title, this.url});

  BannerData.fromJson(jsonRes) {
    id = jsonRes['id'];
    isVisible = jsonRes['isVisible'];
    order = jsonRes['order'];
    type = jsonRes['type'];
    desc = jsonRes['desc'];
    imagePath = jsonRes['imagePath'];
    title = jsonRes['title'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"id": $id,"isVisible": $isVisible,"order": $order,"type": $type,"desc": ${desc != null?'${json.encode(desc)}':'null'},"imagePath": ${imagePath != null?'${json.encode(imagePath)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"url": ${url != null?'${json.encode(url)}':'null'}}';
  }
}


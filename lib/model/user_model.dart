import 'dart:convert' show json;

class UserModel {

  int errorCode;
  String errorMsg;
  UserData data;

  UserModel.fromParams({this.errorCode, this.errorMsg, this.data});

  factory UserModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new UserModel.fromJson(json.decode(jsonStr)) : new UserModel.fromJson(jsonStr);
  
  UserModel.fromJson(jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    data = jsonRes['data'] == null ? null : new UserData.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"errorCode": $errorCode,"errorMsg": ${errorMsg != null?'${json.encode(errorMsg)}':'null'},"data": $data}';
  }
}

class UserData {

  int id;
  int type;
  String email;
  String icon;
  String password;
  String token;
  String username;
  List<dynamic> chapterTops;
  List<int> collectIds;

  UserData.fromParams({this.id, this.type, this.email, this.icon, this.password, this.token, this.username, this.chapterTops, this.collectIds});
  
  UserData.fromJson(jsonRes) {
    id = jsonRes['id'];
    type = jsonRes['type'];
    email = jsonRes['email'];
    icon = jsonRes['icon'];
    password = jsonRes['password'];
    token = jsonRes['token'];
    username = jsonRes['username'];
    chapterTops = jsonRes['chapterTops'] == null ? null : [];

    for (var chapterTopsItem in chapterTops == null ? [] : jsonRes['chapterTops']){
            chapterTops.add(chapterTopsItem);
    }

    collectIds = jsonRes['collectIds'] == null ? null : [];

    for (var collectIdsItem in collectIds == null ? [] : jsonRes['collectIds']){
            collectIds.add(collectIdsItem);
    }
  }

  @override
  String toString() {
    return '{"id": $id,"type": $type,"email": ${email != null?'${json.encode(email)}':'null'},"icon": ${icon != null?'${json.encode(icon)}':'null'},"password": ${password != null?'${json.encode(password)}':'null'},"token": ${token != null?'${json.encode(token)}':'null'},"username": ${username != null?'${json.encode(username)}':'null'},"chapterTops": $chapterTops,"collectIds": $collectIds}';
  }
}


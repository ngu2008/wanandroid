import 'dart:convert' show json;

class BaseModel {

  int errorCode;
  String errorMsg;

  BaseModel.fromParams({ this.errorCode, this.errorMsg});

  factory BaseModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new BaseModel.fromJson(json.decode(jsonStr)) : new BaseModel.fromJson(jsonStr);
  
  BaseModel.fromJson(jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
  }

  @override
  String toString() {
    return '{"errorCode": $errorCode,"errorMsg": ${errorMsg != null?'${json.encode(errorMsg)}':'null'}}';
  }
}


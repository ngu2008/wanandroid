class CommonWebsitModel {

  String errorMsg;
  int errorCode;
  List<DataListBean> data;

  static CommonWebsitModel fromMap(Map<String, dynamic> map) {
    CommonWebsitModel common_websit_model = new CommonWebsitModel();
    common_websit_model.errorMsg = map['errorMsg'];
    common_websit_model.errorCode = map['errorCode'];
    common_websit_model.data = DataListBean.fromMapList(map['data']);
    return common_websit_model;
  }

  static List<CommonWebsitModel> fromMapList(dynamic mapList) {
    List<CommonWebsitModel> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}

class DataListBean {

  String icon;
  String link;
  String name;
  int id;
  int order;
  int visible;

  static DataListBean fromMap(Map<String, dynamic> map) {
    DataListBean dataListBean = new DataListBean();
    dataListBean.icon = map['icon'];
    dataListBean.link = map['link'];
    dataListBean.name = map['name'];
    dataListBean.id = map['id'];
    dataListBean.order = map['order'];
    dataListBean.visible = map['visible'];
    return dataListBean;
  }

  static List<DataListBean> fromMapList(dynamic mapList) {
    List<DataListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["icon"] = icon;
    map["link"] = link;
    map["name"] = name;
    map["id"] = id;
    map["web_order"] = order;
    map["visible"] = visible;

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

}

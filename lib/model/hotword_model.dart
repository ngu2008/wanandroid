class HotwordModel {

  String errorMsg;
  int errorCode;
  List<DataListBean> data;

  static HotwordModel fromMap(Map<String, dynamic> map) {
    HotwordModel hotword_model = new HotwordModel();
    hotword_model.errorMsg = map['errorMsg'];
    hotword_model.errorCode = map['errorCode'];
    hotword_model.data = DataListBean.fromMapList(map['data']);
    return hotword_model;
  }

  static List<HotwordModel> fromMapList(dynamic mapList) {
    List<HotwordModel> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}

class DataListBean {

  String link;
  String name;
  int id;
  int order;
  int visible;

  static DataListBean fromMap(Map<String, dynamic> map) {
    DataListBean dataListBean = new DataListBean();
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
}

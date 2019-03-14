class PrettyModel {


  bool error;
  List<ResultsListBean> results;

  static PrettyModel fromMap(Map<String, dynamic> map) {
    PrettyModel pretty_model = new PrettyModel();
    pretty_model.error = map['error'];
    pretty_model.results = ResultsListBean.fromMapList(map['results']);
    return pretty_model;
  }

  static List<PrettyModel> fromMapList(dynamic mapList) {
    List<PrettyModel> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}

class ResultsListBean {

  String _id;
  String createdAt;
  String desc;
  String publishedAt;
  String source;
  String type;
  String url;
  String who;
  bool used;

  static ResultsListBean fromMap(Map<String, dynamic> map) {
    ResultsListBean resultsListBean = new ResultsListBean();
    resultsListBean._id = map['_id'];
    resultsListBean.createdAt = map['createdAt'];
    resultsListBean.desc = map['desc'];
    resultsListBean.publishedAt = map['publishedAt'];
    resultsListBean.source = map['source'];
    resultsListBean.type = map['type'];
    resultsListBean.url = map['url'];
    resultsListBean.who = map['who'];
    resultsListBean.used = map['used'];
    return resultsListBean;
  }

  static List<ResultsListBean> fromMapList(dynamic mapList) {
    List<ResultsListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

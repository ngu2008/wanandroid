class HotwordResultModel {

  String errorMsg;
  int errorCode;
  DataBean data;

  static HotwordResultModel fromMap(Map<String, dynamic> map) {
    HotwordResultModel hotword_result_model = new HotwordResultModel();
    hotword_result_model.errorMsg = map['errorMsg'];
    hotword_result_model.errorCode = map['errorCode'];
    hotword_result_model.data = DataBean.fromMap(map['data']);
    return hotword_result_model;
  }

  static List<HotwordResultModel> fromMapList(dynamic mapList) {
    List<HotwordResultModel> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}

class DataBean {
  bool over;
  int curPage;
  int offset;
  int pageCount;
  int size;
  int total;
  List<DatasListBean> datas;

  static DataBean fromMap(Map<String, dynamic> map) {
    DataBean dataBean = new DataBean();
    dataBean.over = map['over'];
    dataBean.curPage = map['curPage'];
    dataBean.offset = map['offset'];
    dataBean.pageCount = map['pageCount'];
    dataBean.size = map['size'];
    dataBean.total = map['total'];
    dataBean.datas = DatasListBean.fromMapList(map['datas']);
    return dataBean;
  }

  static List<DataBean> fromMapList(dynamic mapList) {
    List<DataBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class DatasListBean {

  String apkLink;
  String author;
  String chapterName;
  String desc;
  String envelopePic;
  String link;
  String niceDate;
  String origin;
  String projectLink;
  String superChapterName;
  String title;
  bool collect;
  bool fresh;
  int chapterId;
  int courseId;
  int id;
  int publishTime;
  int superChapterId;
  int type;
  int userId;
  int visible;
  int zan;
  List<TagsListBean> tags;

  static DatasListBean fromMap(Map<String, dynamic> map) {
    DatasListBean datasListBean = new DatasListBean();
    datasListBean.apkLink = map['apkLink'];
    datasListBean.author = map['author'];
    datasListBean.chapterName = map['chapterName'];
    datasListBean.desc = map['desc'];
    datasListBean.envelopePic = map['envelopePic'];
    datasListBean.link = map['link'];
    datasListBean.niceDate = map['niceDate'];
    datasListBean.origin = map['origin'];
    datasListBean.projectLink = map['projectLink'];
    datasListBean.superChapterName = map['superChapterName'];
    datasListBean.title = map['title'];
    datasListBean.collect = map['collect'];
    datasListBean.fresh = map['fresh'];
    datasListBean.chapterId = map['chapterId'];
    datasListBean.courseId = map['courseId'];
    datasListBean.id = map['id'];
    datasListBean.publishTime = map['publishTime'];
    datasListBean.superChapterId = map['superChapterId'];
    datasListBean.type = map['type'];
    datasListBean.userId = map['userId'];
    datasListBean.visible = map['visible'];
    datasListBean.zan = map['zan'];
    datasListBean.tags = TagsListBean.fromMapList(map['tags']);
    return datasListBean;
  }

  static List<DatasListBean> fromMapList(dynamic mapList) {
    List<DatasListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class TagsListBean {
  String name;
  String url;

  static TagsListBean fromMap(Map<String, dynamic> map) {
    TagsListBean tagsListBean = new TagsListBean();
    tagsListBean.name = map['name'];
    tagsListBean.url = map['url'];
    return tagsListBean;
  }

  static List<TagsListBean> fromMapList(dynamic mapList) {
    List<TagsListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

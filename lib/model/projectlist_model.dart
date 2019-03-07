import 'dart:convert' show json;

class ProjectTreeListModel {

  int errorCode;
  String errorMsg;
  ProjectTreeListData data;

  ProjectTreeListModel.fromParams({this.errorCode, this.errorMsg, this.data});

  factory ProjectTreeListModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new ProjectTreeListModel.fromJson(json.decode(jsonStr)) : new ProjectTreeListModel.fromJson(jsonStr);

  ProjectTreeListModel.fromJson(jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    data = jsonRes['data'] == null ? null : new ProjectTreeListData.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"errorCode": $errorCode,"errorMsg": ${errorMsg != null?'${json.encode(errorMsg)}':'null'},"data": $data}';
  }
}

class ProjectTreeListData {

  int curPage;
  int offset;
  int pageCount;
  int size;
  int total;
  bool over;
  List<ProjectTreeListDatas> datas;

  ProjectTreeListData.fromParams({this.curPage, this.offset, this.pageCount, this.size, this.total, this.over, this.datas});

  ProjectTreeListData.fromJson(jsonRes) {
    curPage = jsonRes['curPage'];
    offset = jsonRes['offset'];
    pageCount = jsonRes['pageCount'];
    size = jsonRes['size'];
    total = jsonRes['total'];
    over = jsonRes['over'];
    datas = jsonRes['datas'] == null ? null : [];

    for (var datasItem in datas == null ? [] : jsonRes['datas']){
      datas.add(datasItem == null ? null : new ProjectTreeListDatas.fromJson(datasItem));
    }
  }

  @override
  String toString() {
    return '{"curPage": $curPage,"offset": $offset,"pageCount": $pageCount,"size": $size,"total": $total,"over": $over,"datas": $datas}';
  }
}

class ProjectTreeListDatas {

  int chapterId;
  int courseId;
  int id;
  int publishTime;
  int superChapterId;
  int type;
  int userId;
  int visible;
  int zan;
  bool collect;
  bool fresh;
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
  List<ProjectTreeListTag> tags;

  ProjectTreeListDatas.fromParams({this.chapterId, this.courseId, this.id, this.publishTime, this.superChapterId, this.type, this.userId, this.visible, this.zan, this.collect, this.fresh, this.apkLink, this.author, this.chapterName, this.desc, this.envelopePic, this.link, this.niceDate, this.origin, this.projectLink, this.superChapterName, this.title, this.tags});

  ProjectTreeListDatas.fromJson(jsonRes) {
    chapterId = jsonRes['chapterId'];
    courseId = jsonRes['courseId'];
    id = jsonRes['id'];
    publishTime = jsonRes['publishTime'];
    superChapterId = jsonRes['superChapterId'];
    type = jsonRes['type'];
    userId = jsonRes['userId'];
    visible = jsonRes['visible'];
    zan = jsonRes['zan'];
    collect = jsonRes['collect'];
    fresh = jsonRes['fresh'];
    apkLink = jsonRes['apkLink'];
    author = jsonRes['author'];
    chapterName = jsonRes['chapterName'];
    desc = jsonRes['desc'];
    envelopePic = jsonRes['envelopePic'];
    link = jsonRes['link'];
    niceDate = jsonRes['niceDate'];
    origin = jsonRes['origin'];
    projectLink = jsonRes['projectLink'];
    superChapterName = jsonRes['superChapterName'];
    title = jsonRes['title'];
    tags = jsonRes['tags'] == null ? null : [];

    for (var tagsItem in tags == null ? [] : jsonRes['tags']){
      tags.add(tagsItem == null ? null : new ProjectTreeListTag.fromJson(tagsItem));
    }
  }

  @override
  String toString() {
    return '{"chapterId": $chapterId,"courseId": $courseId,"id": $id,"publishTime": $publishTime,"superChapterId": $superChapterId,"type": $type,"userId": $userId,"visible": $visible,"zan": $zan,"collect": $collect,"fresh": $fresh,"apkLink": ${apkLink != null?'${json.encode(apkLink)}':'null'},"author": ${author != null?'${json.encode(author)}':'null'},"chapterName": ${chapterName != null?'${json.encode(chapterName)}':'null'},"desc": ${desc != null?'${json.encode(desc)}':'null'},"envelopePic": ${envelopePic != null?'${json.encode(envelopePic)}':'null'},"link": ${link != null?'${json.encode(link)}':'null'},"niceDate": ${niceDate != null?'${json.encode(niceDate)}':'null'},"origin": ${origin != null?'${json.encode(origin)}':'null'},"projectLink": ${projectLink != null?'${json.encode(projectLink)}':'null'},"superChapterName": ${superChapterName != null?'${json.encode(superChapterName)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"tags": $tags}';
  }
}

class ProjectTreeListTag {

  String name;
  String url;

  ProjectTreeListTag.fromParams({this.name, this.url});

  ProjectTreeListTag.fromJson(jsonRes) {
    name = jsonRes['name'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"name": ${name != null?'${json.encode(name)}':'null'},"url": ${url != null?'${json.encode(url)}':'null'}}';
  }
}


import 'dart:convert' show json;

class TodoListModel {

  int errorCode;
  String errorMsg;
  TodoListData data;

  TodoListModel.fromParams({this.errorCode, this.errorMsg, this.data});

  factory TodoListModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? new TodoListModel.fromJson(json.decode(jsonStr)) : new TodoListModel.fromJson(jsonStr);
  
  TodoListModel.fromJson(jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    data = jsonRes['data'] == null ? null : new TodoListData.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"errorCode": $errorCode,"errorMsg": ${errorMsg != null?'${json.encode(errorMsg)}':'null'},"data": $data}';
  }
}

class TodoListData {

  int type;
  List<TodoListDatas> doneList;
  List<TodoListDatas> todoList;

  TodoListData.fromParams({this.type, this.doneList, this.todoList});
  
  TodoListData.fromJson(jsonRes) {
    type = jsonRes['type'];
    doneList = jsonRes['doneList'] == null ? null : [];

    for (var doneListItem in doneList == null ? [] : jsonRes['doneList']){
            doneList.add(doneListItem == null ? null : new TodoListDatas.fromJson(doneListItem));
    }

    todoList = jsonRes['todoList'] == null ? null : [];

    for (var todoListItem in todoList == null ? [] : jsonRes['todoList']){
            todoList.add(todoListItem == null ? null : new TodoListDatas.fromJson(todoListItem));
    }
  }

  @override
  String toString() {
    return '{"type": $type,"doneList": $doneList,"todoList": $todoList}';
  }
}

class TodoListDatas {

  int date;
  List<TodoData> todoList;

  TodoListDatas.fromParams({this.date, this.todoList});
  
  TodoListDatas.fromJson(jsonRes) {
    date = jsonRes['date'];
    todoList = jsonRes['todoList'] == null ? null : [];

    for (var todoListItem in todoList == null ? [] : jsonRes['todoList']){
            todoList.add(todoListItem == null ? null : new TodoData.fromJson(todoListItem));
    }
  }

  @override
  String toString() {
    return '{"date": $date,"todoList": $todoList}';
  }
}

class TodoData {

  TodoData();

  TodoData.origin(String title){
    this.title = title;
  }

  int completeDate;
  int date;
  int id;
  int priority;
  int status;
  int type;
  int userId;
  String completeDateStr;
  String content;
  String dateStr;
  String title;

  TodoData.fromParams({this.completeDate, this.date, this.id, this.priority, this.status, this.type, this.userId, this.completeDateStr, this.content, this.dateStr, this.title});
  
  TodoData.fromJson(jsonRes) {
    completeDate = jsonRes['completeDate'];
    date = jsonRes['date'];
    id = jsonRes['id'];
    priority = jsonRes['priority'];
    status = jsonRes['status'];
    type = jsonRes['type'];
    userId = jsonRes['userId'];
    completeDateStr = jsonRes['completeDateStr'];
    content = jsonRes['content'];
    dateStr = jsonRes['dateStr'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"completeDate": $completeDate,"date": $date,"id": $id,"priority": $priority,"status": $status,"type": $type,"userId": $userId,"completeDateStr": ${completeDateStr != null?'${json.encode(completeDateStr)}':'null'},"content": ${content != null?'${json.encode(content)}':'null'},"dateStr": ${dateStr != null?'${json.encode(dateStr)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'}}';
  }
}




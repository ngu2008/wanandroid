import '../model/UserModel.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  static final User singleton = User._internal();

  factory User() {
    return singleton;
  }

  User._internal();

  List<String> cookie;
  String userName;

  void saveUserInfo(UserModel _userModel,Response response){
        List<String> cookies = response.headers["set-cookie"];
        cookie = cookies;
        userName = _userModel.data.username;
        saveInfo();
  }

  Future<Null> getUserInfo() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  List<String> cookies = sp.getStringList("cookies");
  if (cookies != null) {
    cookie = cookies;
  }
  String username = sp.getString("username");
  if(username!=null){
    userName = username;
  }
}

  saveInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList("cookies", cookie);
    sp.setString("username", userName);
  }

  void clearUserInfor(){
    cookie = null;
    userName = null;
    clearInfo();
  }
  
  clearInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList("cookies", null);
    sp.setString("username", null);
  }
}

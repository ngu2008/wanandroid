import 'package:flutter/material.dart';


class StyleUtil {

  /**
   * TextStyle:封装
   * colors:颜色
   * fontsizes：字体大小
   * isFontWeight：是否加粗
   */
  static TextStyle  getTextStyle(Color colors,double fontsizes,bool isFontWeight){
    return TextStyle(
      color:colors,
      fontSize: fontsizes,
      fontWeight: isFontWeight == true ? FontWeight.bold : FontWeight.normal ,
    );
  }
  /**
   * 组件加上下左右padding
   * w:所要加padding的组件
   * all:加多少padding
   */
  static Widget getPadding(Widget w,double all){
    return Padding(
      child:w,
      padding:EdgeInsets.all(all),
    );
  }

  /**
   * 组件选择性加padding
   * 这里用了位置可选命名参数{param1,param2,...}来命名参数，也调用的时候可以不传
   *
   */
  static Widget getPaddingfromLTRB(Widget w,{double l,double t,double,r,double b}){
    return Padding(
      child:w,
      padding:EdgeInsets.fromLTRB(l ?? 0,t ?? 0,r ?? 0,b ?? 0),
    );
  }



}
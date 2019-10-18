import 'package:flutter/material.dart';
import 'package:student_guidance/page/Edit/EditProfile.dart';
import 'package:student_guidance/page/Views/view-profile-teacher.dart';
import 'package:student_guidance/page/dashboard/dashboard.dart';
import 'package:student_guidance/page/home/home.dart';
import 'package:student_guidance/page/login/login.dart';
import 'package:student_guidance/page/splash/splash.dart';

class UIdata {
  static Icon backIcon = new Icon(Icons.arrow_back_ios);
  static Icon menuIcon = new Icon(Icons.menu);
  static Icon searchIcon = new Icon(Icons.search);

  static Map<String, WidgetBuilder> routes = {
    LoginPage.tag: (context) => LoginPage(),
    SplashPage.tag:(context) => SplashPage(),
    Home.tag: (context) => Home(),
    Dashboard.tag: (context) => Dashboard(),
    ViewTeacher.tag: (context) => ViewTeacher(),
    EditProfile.tag: (context) => EditProfile(),
  };

  static String loginPageTag = LoginPage.tag;
  static String homeTag = Home.tag;
  static String splashPage = SplashPage.tag;
  static String dashboardTag = Dashboard.tag;
  static String viewTeacherTag = ViewTeacher.tag;
  static String editProfileTag = EditProfile.tag;

  static String fontFamily = 'Kanit';
}

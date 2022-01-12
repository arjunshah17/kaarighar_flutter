import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:kaarighar/common/constants.dart';
import 'package:kaarighar/employer/model/EmployeeUser.dart';
import 'package:kaarighar/jobseeker/model/Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
setUser(String token,String userType,String userId)async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("user_type", userType);
  prefs.setString("user_id", userId);
  prefs.setString("token", token);
}
setUserJob(String token,String userType,Map<String,dynamic>  user)async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("user_type", userType);
  prefs.setString("user",jsonEncode(JobSeekerUser.fromJson(user)));
  prefs.setString("token", token);
}
Future<JobSeekerUser?> getUserJob() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
 var value= prefs.getString("user");
 return JobSeekerUser.fromJson(jsonDecode(value!));

}

setUserEmployee(String token,String userType,Map<String,dynamic>  user)async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("user_type", userType);
  prefs.setString("user",jsonEncode(EmployeeUser.fromJson(user)));
  prefs.setString("token", token);
}
Future<EmployeeUser?> getUserEmployee() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var value= prefs.getString("user");
  return EmployeeUser.fromJson(jsonDecode(value!));

}
Future<String?> getUserId()async {

  try {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("user_id"));
    return prefs.getString("user_id");
  }
  catch(ex){
    return null;

  }
}
makeLogout()
async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();

}

Future<String?> getUserType()async{
try {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("user_type");
}
catch(ex){
  return null;

}
}

Future<String?> getUserToken()async {

  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    return prefs.getString("token");
  }
  catch(ex){
    return null;

  }
}
const String user="kaarighar";

showLoader(BuildContext context){
  Loader.show(context,progressIndicator:CircularProgressIndicator(),isSafeAreaOverlay: false);
}
dissmissLoader(BuildContext context){
  Loader.hide();
}
bool isValidEmail(String value) {
  return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(value);
}


void showSuccess(BuildContext context,String show){
  Fluttertoast.showToast(
    msg:show,

    backgroundColor: Colors.green,

  );
}
void showError(BuildContext context,String show){
  Fluttertoast.showToast(
    msg:show,

      backgroundColor: Colors.red,

  );
}
Dio getDio(){
  var dio = Dio();
  dio.options.baseUrl = Constants().appUrl;
  return dio;
}
Future<Options> getHeaderOption()async{

return Options(headers: {
    "auth-token":await getUserToken()
  });
}

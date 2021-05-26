import 'dart:async';
import 'dart:io';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/services/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class NetworkUtil {

  static Future<Map> httpPost(Map data,String apiEndPoint) async {
    String url = baseURL+apiEndPoint;
    try{
      LocalData _localData = Get.find<LocalData>();
      print(url);
      print(json.encode(data));
      final response = await http.post(url,body:data,headers: {'authorization':_localData.token});
      Loader.hide();
      print(json.decode(response.body));
      if (response.statusCode == 200 || response.statusCode == 400) {
        Loader.hide();
        return checkForError(json.decode(response.body));
      } else {
        Loader.hide();
        return checkForError({'status':69});
      }
    }catch(e){
      print(e);
      Loader.hide();
      return checkForError({'status':69});
    }
  }

  static Future<Map> httpPostComplex(Map data,String apiEndPoint,[BuildContext context]) async {
    String url = baseURL+apiEndPoint;
    try{
      if(context!=null)
        Loader.show(context,progressIndicator:CircularProgressIndicator(backgroundColor: primaryColor,));
      LocalData _localData= Provider.of<LocalData>(context,listen: false);
      print(url);
      HttpClient httpClient = new HttpClient();
      print(data);
      HttpClientRequest request = await httpClient.postUrl(Uri.parse(url)).timeout(Duration(seconds: 10));
      request.headers.set('content-type', 'application/json');
      request.headers.add('Authorization', _localData.token);
      request.add(utf8.encode(json.encode(data)));
      HttpClientResponse response = await request.close();
      Loader.hide();
      if (response.statusCode == 200 || response.statusCode == 400) {
        String reply = await response.transform(utf8.decoder).join();
        print(json.decode(reply));
        return checkForError(json.decode(reply));
      } else {
        Loader.hide();
        return checkForError({'status':69});
      }
    }catch(e){
      print(e);
      Loader.hide();
      return checkForError({'status':69});
    }
  }

  static Future<Map> httpGet({String apiEndPoint, BuildContext context}) async {
    try{
      print(apiEndPoint);
      if(context!=null)
        Loader.show(context,progressIndicator:CircularProgressIndicator(backgroundColor: primaryColor,));
      LocalData _localData = Get.find<LocalData>();
      final response = await http.get(baseURL+apiEndPoint,headers: {'authorization':_localData.token}).timeout(Duration(seconds: 10));
      Loader.hide();
      print(json.decode(response.body));
      if (response.statusCode == 200 || response.statusCode == 400) {
        return checkForError(json.decode(response.body));
      } else {
        return checkForError({'status':3 , 'message' : 'error ${response.statusCode}'});
      }
    }on TimeoutException catch (_) {
      Loader.hide();
      return checkForError({'status':3,'message':'Request Timeout'});
    } on SocketException catch (_) {
      Loader.hide();
      return checkForError({'status':3});
    }
  }

  static Future<Map> httpGetFuture({String apiEndPoint, BuildContext context}) async {
    print('demo');
    try{
      LocalData localData= Provider.of<LocalData>(context,listen: false);
      print(baseURL+apiEndPoint);
      final response = await http.get(baseURL+apiEndPoint,headers: {'Authorization':localData.token}).timeout(Duration(seconds: 10));
      print(json.decode(response.body));
      if (response.statusCode == 200 || response.statusCode == 400) {
        return json.decode(response.body);
      } else {
        return {'status':0 , 'message' : 'error ${response.statusCode}'};
      }
    }on TimeoutException catch (_) {
      Navigator.pop(context);
      Get.snackbar('Failed', "Request Timeout",colorText: Colors.white,backgroundColor: primaryColor);
      return {'status':0,'message':''};
    } on SocketException catch (_) {
      return {'status':0,'message':'Socket Exception'};
    }
  }

  static Future<Map> httpPostFuture({String apiEndPoint, BuildContext context,Map data}) async {
    try{
      LocalData _localData = Get.find<LocalData>();
      final response = await http.post(baseURL+apiEndPoint,headers: {'authorization':_localData.token},body: data).timeout(Duration(seconds: 10));
      print(json.decode(response.body));
      if (response.statusCode == 200 || response.statusCode == 400) {
        return json.decode(response.body);
      } else {
        return {'status':0 , 'message' : 'error ${response.statusCode}'};
      }
    }on TimeoutException catch (_) {
      Navigator.pop(context);
      Get.snackbar('Failed', "Request Timeout",colorText: Colors.white,backgroundColor: primaryColor);
      return {'status':0,'message':''};
    } on SocketException catch (_) {
      return {'status':0,'message':'Socket Exception'};
    }
  }

  static Map<String , dynamic> checkForError(Map data){
    switch(data['status']){
      case 0 :
        Fluttertoast.showToast(msg: data['message']??'Something Went Wrong');
        print(data);
        return data;
        break;
      case 1 :
        if(data['message']!=null)
          Fluttertoast.showToast(msg:  data['message']);
        return data;
        break;
      case 3 :
        print('failed');
        Fluttertoast.showToast(msg:data['message']??'Something Went Wrong');
        return null;
        break;
      default:
        print('exception');
        Fluttertoast.showToast(msg: 'Something Went Wrong');
        return null;
    }
  }

  static performOperation({Map data, Function operation}){
    if(data!=null){
      operation();
    }
  }
}

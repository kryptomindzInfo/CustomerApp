import 'package:beyond_wallet/models/login_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData extends ChangeNotifier{
  User data = new User();
  String token;

  saveToSharedPrefs(User data,String token) async {
    SharedPreferences _prefs =await SharedPreferences.getInstance();
    _prefs.setString('id' , data.id);
    _prefs.setString('name' , data.name);
    _prefs.setString('mobile' , data.mobile);
    _prefs.setString('email' , data.address);
    _prefs.setString('username' , data.username);
    _prefs.setString('token', token);
  }

   getFromSharedPrefs() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    data.id = _prefs.getString('id');
    data.name = _prefs.getString('name');
    data.mobile = _prefs.getString('mobile');
    data.email = _prefs.getString('email');
    data.username = _prefs.getString('username');
    token = _prefs.getString('token');
    return data;
  }
}
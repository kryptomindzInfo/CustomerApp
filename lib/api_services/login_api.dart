import 'dart:async';
import 'dart:io';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginApi {
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    String url = baseURL+"user/login";
    try{
      print(loginRequestModel.toJson());
      final response = await http.post(url, body: loginRequestModel.toJson()).timeout(Duration(seconds: 10));
      print(json.decode(response.body));
      if (response.statusCode == 200 || response.statusCode == 400) {
        print(json.decode(response.body));
        var body = json.decode(response.body);
        return body['status']!=1?null:LoginResponseModel.fromJson(body);
      } else {
        print('failed to load data');
        return null;
      }
    }on TimeoutException catch (_) {
      return null;
    } on SocketException catch (_) {
      return null;
    }
  }
}

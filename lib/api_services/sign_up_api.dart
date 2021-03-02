import 'dart:async';
import 'dart:io';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/sign_up_model.dart';
import 'package:beyond_wallet/models/verify_otp_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpApi {
  Future<SignUpResponseModel> signUp(SignUpRequestModel signUpRequestModel) async {
    String url = baseURL+"user/signup";
    try{
      print(signUpRequestModel.toJson());
      final response = await http.post(url, body: signUpRequestModel.toJson()).timeout(Duration(seconds: 10));
      print(json.decode(response.body));
      if (response.statusCode == 200 || response.statusCode == 400) {
        print(json.decode(response.body));
        return SignUpResponseModel.fromJson(json.decode(response.body));
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

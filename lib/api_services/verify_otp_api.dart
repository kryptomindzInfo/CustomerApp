import 'dart:async';
import 'dart:io';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/verify_otp_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VerifyOTPApi {
  Future<VerifyOtpResponseModel> verify(VerifyOtpRequestModel verifyOtpRequestModel) async {
    String url = baseURL+"user/verify";
    print(verifyOtpRequestModel.toJson());
    try{
      final response = await http.post(url, body: verifyOtpRequestModel.toJson()).timeout(Duration(seconds: 10));
      if (response.statusCode == 200 || response.statusCode == 400) {
        print(json.decode(response.body));
        return VerifyOtpResponseModel.fromJson(json.decode(response.body));
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

import 'dart:async';
import 'dart:io';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/send_money_to_non_wallet_model.dart';
import 'package:beyond_wallet/models/send_money_to_wallet_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SendMoneyToNonWalletApi {
  Future<SendMoneyToNonWalletResponseModel> sendMoneyToNonWallet(String  token,SendMoneyToNonWalletRequestModel requestModel) async {
    String url = baseURL+"user/interBank/sendMoneyToNonWallet";
    try{
      HttpClient httpClient = new HttpClient();
      print(requestModel.toJson());
      HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.headers.add('Authorization', token);
      request.add(utf8.encode(json.encode(requestModel.toJson())));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200 || response.statusCode == 400) {
        String reply = await response.transform(utf8.decoder).join();
        var body = json.decode(reply);
        if(body['status']==1){
          return SendMoneyToNonWalletResponseModel.fromJson(body);
        }else{
          SendMoneyToNonWalletResponseModel responseModel = new SendMoneyToNonWalletResponseModel();
          responseModel.status=0;
          return responseModel;
        }

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

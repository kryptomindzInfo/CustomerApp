import 'dart:async';
import 'dart:io';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/get_merchant_penalty_rule_model.dart';
import 'dart:convert';

class GetMerchantPenaltyRuleApi {
  Future<GetMerchantPenaltyRuleResponseModel> getMerchantPenaltyRule(GetMerchantPenaltyRuleRequestModel requestModel, String  token) async {
    String url = baseURL+"user/getMerchantPenaltyRule";
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
        print(body);
        return GetMerchantPenaltyRuleResponseModel.fromJson(body);

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

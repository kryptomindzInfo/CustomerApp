import 'dart:async';
import 'dart:io';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/get_balance_model.dart';
import 'package:beyond_wallet/models/get_contacts_model.dart';
import 'package:beyond_wallet/models/get_marchent_list_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetMerchantListApi {
  Future<GetMerchantListResponseModel> getMerchantList(String  token) async {
    String url = baseURL+"user/listMerchants";
    try{
      final response = await http.get(url,headers: {'Authorization' : token});
      print(json.decode(response.body));
      if (response.statusCode == 200 || response.statusCode == 400) {
        print(json.decode(response.body));
        return GetMerchantListResponseModel.fromJson(json.decode(response.body));
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

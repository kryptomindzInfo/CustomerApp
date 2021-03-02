import 'dart:async';
import 'dart:io';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/get_banks_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetBanksApi {
  Future<GetBanksResponseModel> getBanks(String  token) async {
    String url = baseURL+"user/getBanks";
    try{
      final response = await http.get(url,headers: {'Authorization' : token});
      print(json.decode(response.body));
      if (response.statusCode == 200 || response.statusCode == 400) {
        print(json.decode(response.body));
        return GetBanksResponseModel.fromJson(json.decode(response.body));
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

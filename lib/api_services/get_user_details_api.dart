import 'dart:async';
import 'dart:io';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/get_user_details_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetUserDetailsApi {
  Future<GetUserDetailsResponseModel> getUserDetails(String  token,String mobile) async {
    GetUserDetailsRequestModel requestModel = new GetUserDetailsRequestModel();
    requestModel.mobile= mobile;
    String url = baseURL+"user/getUser";
    try{
      final response = await http.post(url,headers: {'Authorization' : token},body: requestModel.toJson());
      print(json.decode(response.body));
      if (response.statusCode == 200 || response.statusCode == 400) {
        var body = json.decode(response.body);
        if(body['status']==1){
          return GetUserDetailsResponseModel.fromJson(json.decode(response.body));
        }else{
          GetUserDetailsResponseModel responseModel = new GetUserDetailsResponseModel();
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

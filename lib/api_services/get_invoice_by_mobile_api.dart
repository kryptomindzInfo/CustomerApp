import 'dart:async';
import 'dart:io';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/get_invoice_by_mobile_model.dart';
import 'package:beyond_wallet/models/merchant_details_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetInvoiceByMobileApi {
  Future<GetInvoiceByMobileResponseModel> getInvoiceByMobile(GetInvoiceByMobileRequestModel requestModel, String  token) async {
    String url = baseURL+"user/getInvoicesForMobile";
    try{
      final response = await http.post(url,headers: {'Authorization' : token},body: requestModel.toJson());
      print(json.decode(response.body));
      if (response.statusCode == 200 || response.statusCode == 400) {
        print(json.decode(response.body));
        return GetInvoiceByMobileResponseModel.fromJson(json.decode(response.body));
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

import 'dart:async';
import 'dart:io';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/get_invoice_by_cc_model.dart';
import 'package:beyond_wallet/models/get_invoice_by_mobile_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetInvoiceByCCApi {
  Future<GetInvoiceByCcResponseModel> getInvoiceByCC(GetInvoiceByCcRequestModel requestModel, String  token) async {
    String url = baseURL+"user/getInvoicesForCustomerCode";
    try{
      final response = await http.post(url,headers: {'Authorization' : token},body: requestModel.toJson());
      if (response.statusCode == 200 || response.statusCode == 400) {
        var body = json.decode(response.body);
        if(body['status']==1){
          return GetInvoiceByCcResponseModel.fromJson(json.decode(response.body));
        }else{
           GetInvoiceByCcResponseModel responseModel = new GetInvoiceByCcResponseModel();
           responseModel.status = 0;
           responseModel.invoice=[];
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

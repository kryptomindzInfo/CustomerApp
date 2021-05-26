import 'dart:async';
import 'dart:io';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/get_invoice_by_bill_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetInvoiceByBillApi {
  Future<GetInvoiceByBillResponseModel> getInvoiceByBill(GetInvoiceByBillRequestModel requestModel, String  token) async {
    String url = baseURL+"user/getInvoicesByNumber";
    try{
      final response = await http.post(url,headers: {'Authorization' : token},body: requestModel.toJson());
      print(json.decode(response.body));
      if (response.statusCode == 200 || response.statusCode == 400) {
        print(json.decode(response.body));
        var body = json.decode(response.body);
        if(body['status']==1){
          return GetInvoiceByBillResponseModel.fromJson(json.decode(response.body));
        }else{
          GetInvoiceByBillResponseModel responseModel = new GetInvoiceByBillResponseModel();
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

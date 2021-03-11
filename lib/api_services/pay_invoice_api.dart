import 'dart:async';
import 'dart:io';
import 'package:beyond_wallet/constants/constants.dart';
import 'dart:convert';
import 'package:beyond_wallet/models/pay_invoice_model.dart';

class PayInvoiceApi {
  Future<PayInvoiceResponseModel> payInvoice(String  token,PayInvoiceRequestModel requestModel) async {
    String url = baseURL+"user/payInvoice";
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
        if(body['status']==1){
          return PayInvoiceResponseModel.fromJson(body);
        }else{
          PayInvoiceResponseModel responseModel = new PayInvoiceResponseModel();
          responseModel.status=body['status'];
          responseModel.message = body['message'];
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

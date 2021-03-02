import 'dart:async';
import 'dart:io';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/upload_document_hash_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UploadDocsHashApi {
  Future<UploadDocsHashResponseModel> uploadDocsHash(UploadDocsHashRequestModel requestModel, String  token) async {
    String url = baseURL+"user/saveUploadedDocsHash";
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.headers.add('Authorization', token);
    print(json.encode(requestModel.toJson()));
    request.add(utf8.encode(json.encode(requestModel.toJson())));
    HttpClientResponse response = await request.close();
    if (response.statusCode == 200 || response.statusCode == 400) {
      String reply = await response.transform(utf8.decoder).join();
      print(reply);
      return UploadDocsHashResponseModel.fromJson(json.decode(reply));
    } else {
      return null;
    }
  }
}

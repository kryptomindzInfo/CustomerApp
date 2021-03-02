import 'dart:async';
import 'dart:io';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/upload_documents_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UploadDocumentsApi {
  Future<UploadDocsResponseModel> uploadDocuments(File file) async {
    String url = "http://91d90ac373dc.sn.mynetname.net:30301/api/ipfsUpload";
    try{
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(
          http.MultipartFile(
              'file',
              file.readAsBytes().asStream(),
              file.lengthSync(),
              filename: file.path.split("/").last
          )
      );

      var streamedResponse = await request.send();
      var response =await http.Response.fromStream(streamedResponse);
      print(response.body);
      return UploadDocsResponseModel.fromJson(json.decode(response.body));

    }on TimeoutException catch (_) {
      return null;
    } on SocketException catch (_) {
      return null;
    }
  }
}

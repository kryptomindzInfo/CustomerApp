// To parse this JSON data, do
//
//     final uploadDocsResponseModel = uploadDocsResponseModelFromJson(jsonString);

import 'dart:convert';

UploadDocsResponseModel uploadDocsResponseModelFromJson(String str) => UploadDocsResponseModel.fromJson(json.decode(str));

String uploadDocsResponseModelToJson(UploadDocsResponseModel data) => json.encode(data.toJson());

class UploadDocsResponseModel {
  UploadDocsResponseModel({
    this.status,
    this.message,
    this.hash,
  });

  int status;
  String message;
  String hash;

  factory UploadDocsResponseModel.fromJson(Map<String, dynamic> json) => UploadDocsResponseModel(
    status: json["status"],
    message: json["message"],
    hash: json["hash"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "hash": hash,
  };
}

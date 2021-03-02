// To parse this JSON data, do
//
//     final skipUploadDocsResponseModel = skipUploadDocsResponseModelFromJson(jsonString);

import 'dart:convert';

SkipUploadDocsResponseModel skipUploadDocsResponseModelFromJson(String str) => SkipUploadDocsResponseModel.fromJson(json.decode(str));

String skipUploadDocsResponseModelToJson(SkipUploadDocsResponseModel data) => json.encode(data.toJson());

class SkipUploadDocsResponseModel {
  SkipUploadDocsResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory SkipUploadDocsResponseModel.fromJson(Map<String, dynamic> json) => SkipUploadDocsResponseModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}

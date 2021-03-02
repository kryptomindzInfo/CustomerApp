// To parse this JSON data, do
//
//     final verifyOtpRequestModel = verifyOtpRequestModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpRequestModel verifyOtpRequestModelFromJson(String str) => VerifyOtpRequestModel.fromJson(json.decode(str));

String verifyOtpRequestModelToJson(VerifyOtpRequestModel data) => json.encode(data.toJson());

class VerifyOtpRequestModel {
  VerifyOtpRequestModel({
    this.mobile,
    this.email,
  });

  String mobile;
  String email;

  factory VerifyOtpRequestModel.fromJson(Map<String, dynamic> json) => VerifyOtpRequestModel(
    mobile: json["mobile"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "mobile": mobile,
    "email": email,
  };
}


VerifyOtpResponseModel verifyOtpResponseModelFromJson(String str) => VerifyOtpResponseModel.fromJson(json.decode(str));

String verifyOtpResponseModelToJson(VerifyOtpResponseModel data) => json.encode(data.toJson());

class VerifyOtpResponseModel {
  VerifyOtpResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) => VerifyOtpResponseModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}

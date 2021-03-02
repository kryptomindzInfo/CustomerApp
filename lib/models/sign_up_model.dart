// To parse this JSON data, do
//
//     final signUpRequestModel = signUpRequestModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

SignUpRequestModel signUpRequestModelFromJson(String str) => SignUpRequestModel.fromJson(json.decode(str));

String signUpRequestModelToJson(SignUpRequestModel data) => json.encode(data.toJson());

class SignUpRequestModel extends ChangeNotifier{
  SignUpRequestModel({
    this.name,
    this.mobile,
    this.email,
    this.address,
    this.password,
    this.otp,
  });

  String name;
  String mobile;
  String email;
  String address;
  String password;
  String otp;

  factory SignUpRequestModel.fromJson(Map<String, dynamic> json) => SignUpRequestModel(
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    address: json["address"],
    password: json["password"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile": mobile,
    "email": email,
    "address": address,
    "password": password,
    "otp": otp,
  };
}


SignUpResponseModel signUpResponseModelFromJson(String str) => SignUpResponseModel.fromJson(json.decode(str));

String signUpResponseModelToJson(SignUpResponseModel data) => json.encode(data.toJson());

class SignUpResponseModel {
  SignUpResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) => SignUpResponseModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}

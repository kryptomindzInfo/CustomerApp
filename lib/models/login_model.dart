// To parse this JSON data, do
//
//     final loginRequestModel = loginRequestModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

LoginRequestModel loginRequestModelFromJson(String str) => LoginRequestModel.fromJson(json.decode(str));

String loginRequestModelToJson(LoginRequestModel data) => json.encode(data.toJson());

class LoginRequestModel {
  LoginRequestModel({
    this.username,
    this.password,
  });

  String username;
  String password;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) => LoginRequestModel(
    username: json["username"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
  };
}


LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel extends ChangeNotifier{
  LoginResponseModel({
    this.status,
    this.user,
    this.token,
  });

  int status;
  User user;
  String token;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    status: json["status"],
    user: User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "user": user.toJson(),
    "token": token,
  };
}

class User {
  User({
    this.bankId,
    this.status,
    this.statusDesc,
    this.contactList,
    this.id,
    this.docsHash,
    this.name,
    this.mobile,
    this.email,
    this.address,
    this.username,
    this.v,
  });

  dynamic bankId;
  int status;
  String statusDesc;
  List<dynamic> contactList;
  String id;
  List<dynamic> docsHash;
  String name;
  String mobile;
  String email;
  String address;
  String username;
  int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
    bankId: json["bank_id"],
    status: json["status"],
    statusDesc: json["status_desc"],
    contactList: List<dynamic>.from(json["contact_list"].map((x) => x)),
    id: json["_id"],
    docsHash: List<dynamic>.from(json["docs_hash"].map((x) => x)),
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    address: json["address"],
    username: json["username"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "bank_id": bankId,
    "status": status,
    "status_desc": statusDesc,
    "contact_list": List<dynamic>.from(contactList.map((x) => x)),
    "_id": id,
    "docs_hash": List<dynamic>.from(docsHash.map((x) => x)),
    "name": name,
    "mobile": mobile,
    "email": email,
    "address": address,
    "username": username,
    "__v": v,
  };
}

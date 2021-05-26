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


// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);


LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.status,
    this.bank,
    this.user,
    this.token,
  });

  int status;
  Bank bank;
  User user;
  String token;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    status: json["status"],
    bank: json["bank"]==null?null:Bank.fromJson(json["bank"]),
    user: User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "bank": bank.toJson(),
    "user": user.toJson(),
    "token": token,
  };
}

class Bank {
  Bank({
    this.walletIds,
    this.modifiedAt,
    this.initialSetup,
    this.status,
    this.totalTrans,
    this.workingFrom,
    this.workingTo,
    this.totalBranches,
    this.totalCashiers,
    this.totalPartners,
    this.id,
    this.createdAt,
    this.name,
    this.bcode,
    this.address1,
    this.state,
    this.country,
    this.zip,
    this.ccode,
    this.mobile,
    this.username,
    this.email,
    this.userId,
    this.logo,
    this.contract,
    this.password,
    this.v,
  });

  WalletIds walletIds;
  dynamic modifiedAt;
  bool initialSetup;
  int status;
  int totalTrans;
  String workingFrom;
  String workingTo;
  int totalBranches;
  int totalCashiers;
  int totalPartners;
  String id;
  DateTime createdAt;
  String name;
  String bcode;
  String address1;
  String state;
  String country;
  String zip;
  String ccode;
  String mobile;
  String username;
  String email;
  String userId;
  String logo;
  String contract;
  String password;
  int v;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
    walletIds: json["wallet_ids"]!=null?WalletIds.fromJson(json["wallet_ids"]):null,
    modifiedAt: json["modified_at"],
    initialSetup: json["initial_setup"],
    status: json["status"],
    totalTrans: json["total_trans"],
    workingFrom: json["working_from"],
    workingTo: json["working_to"],
    totalBranches: json["total_branches"],
    totalCashiers: json["total_cashiers"],
    totalPartners: json["total_partners"],
    id: json["_id"],
    createdAt: DateTime.parse(json["created_at"]),
    name: json["name"],
    bcode: json["bcode"],
    address1: json["address1"],
    state: json["state"],
    country: json["country"],
    zip: json["zip"],
    ccode: json["ccode"],
    mobile: json["mobile"],
    username: json["username"],
    email: json["email"],
    userId: json["user_id"],
    logo: json["logo"],
    contract: json["contract"],
    password: json["password"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "wallet_ids": walletIds.toJson(),
    "modified_at": modifiedAt,
    "initial_setup": initialSetup,
    "status": status,
    "total_trans": totalTrans,
    "working_from": workingFrom,
    "working_to": workingTo,
    "total_branches": totalBranches,
    "total_cashiers": totalCashiers,
    "total_partners": totalPartners,
    "_id": id,
    "created_at": createdAt.toIso8601String(),
    "name": name,
    "bcode": bcode,
    "address1": address1,
    "state": state,
    "country": country,
    "zip": zip,
    "ccode": ccode,
    "mobile": mobile,
    "username": username,
    "email": email,
    "user_id": userId,
    "logo": logo,
    "contract": contract,
    "password": password,
    "__v": v,
  };
}

class WalletIds {
  WalletIds({
    this.operational,
    this.master,
    this.escrow,
    this.infraOperational,
    this.infraMaster,
  });

  String operational;
  String master;
  String escrow;
  String infraOperational;
  String infraMaster;

  factory WalletIds.fromJson(Map<String, dynamic> json) => WalletIds(
    operational: json["operational"],
    master: json["master"],
    escrow: json["escrow"],
    infraOperational: json["infra_operational"],
    infraMaster: json["infra_master"],
  );

  Map<String, dynamic> toJson() => {
    "operational": operational,
    "master": master,
    "escrow": escrow,
    "infra_operational": infraOperational,
    "infra_master": infraMaster,
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
    this.messages,
    this.name,
    this.mobile,
    this.email,
    this.address,
    this.username,
    this.v,
    this.country,
    this.idName,
    this.idNumber,
    this.idType,
    this.lastName,
    this.state,
    this.validTill,
    this.walletId,
    this.merchantList,
  });

  String bankId;
  int status;
  String statusDesc;
  List<String> contactList;
  String id;
  List<DocsHash> docsHash;
  List<dynamic> messages;
  String name;
  String mobile;
  String email;
  String address;
  String username;
  int v;
  String country;
  String idName;
  String idNumber;
  String idType;
  String lastName;
  String state;
  String validTill;
  String walletId;
  List<MerchantList> merchantList;

  factory User.fromJson(Map<String, dynamic> json) => User(
    bankId: json["bank_id"],
    status: json["status"],
    statusDesc: json["status_desc"],
    contactList: List<String>.from(json["contact_list"].map((x) => x)),
    id: json["_id"],
    docsHash: List<DocsHash>.from(json["docs_hash"].map((x) => DocsHash.fromJson(x))),
    messages: List<dynamic>.from(json["messages"].map((x) => x)),
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    address: json["address"],
    username: json["username"],
    v: json["__v"],
    country: json["country"],
    idName: json["id_name"],
    idNumber: json["id_number"],
    idType: json["id_type"],
    lastName: json["last_name"],
    state: json["state"],
    validTill: json["valid_till"],
    walletId: json["wallet_id"],
    merchantList: List<MerchantList>.from(json["merchant_list"].map((x) => MerchantList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bank_id": bankId,
    "status": status,
    "status_desc": statusDesc,
    "contact_list": List<dynamic>.from(contactList.map((x) => x)),
    "_id": id,
    "docs_hash": List<dynamic>.from(docsHash.map((x) => x.toJson())),
    "messages": List<dynamic>.from(messages.map((x) => x)),
    "name": name,
    "mobile": mobile,
    "email": email,
    "address": address,
    "username": username,
    "__v": v,
    "country": country,
    "id_name": idName,
    "id_number": idNumber,
    "id_type": idType,
    "last_name": lastName,
    "state": state,
    "valid_till": validTill,
    "wallet_id": walletId,
    "merchant_list": List<dynamic>.from(merchantList.map((x) => x.toJson())),
  };
}

class DocsHash {
  DocsHash({
    this.id,
    this.name,
    this.type,
    this.hash,
  });

  String id;
  String name;
  String type;
  String hash;

  factory DocsHash.fromJson(Map<String, dynamic> json) => DocsHash(
    id: json["_id"],
    name: json["name"],
    type: json["type"],
    hash: json["hash"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "type": type,
    "hash": hash,
  };
}

class MerchantList {
  MerchantList({
    this.merchantId,
    this.id,
  });

  String merchantId;
  String id;

  factory MerchantList.fromJson(Map<String, dynamic> json) => MerchantList(
    merchantId: json["merchant_id"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "merchant_id": merchantId,
    "_id": id,
  };
}

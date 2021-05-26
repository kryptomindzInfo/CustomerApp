// To parse this JSON data, do
//
//     final addedMerchantResponseModel = addedMerchantResponseModelFromJson(jsonString);

import 'dart:convert';

AddedMerchantResponseModel addedMerchantResponseModelFromJson(String str) => AddedMerchantResponseModel.fromJson(json.decode(str));

String addedMerchantResponseModelToJson(AddedMerchantResponseModel data) => json.encode(data.toJson());

class AddedMerchantResponseModel {
  AddedMerchantResponseModel({
    this.status,
    this.message,
    this.list,
  });

  int status;
  String message;
  List<ListElement> list;

  factory AddedMerchantResponseModel.fromJson(Map<String, dynamic> json) => AddedMerchantResponseModel(
    status: json["status"],
    message: json["message"],
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ListElement {
  ListElement({
    this.walletIds,
    this.creatorDesc,
    this.billsPaid,
    this.billsRaised,
    this.amountCollected,
    this.amountCollectedDesc,
    this.lastPaidAt,
    this.amountDue,
    this.isPrivate,
    this.id,
    this.name,
    this.logo,
    this.description,
    this.documentHash,
    this.email,
    this.mobile,
    this.code,
    this.username,
    this.bankId,
    this.status,
    this.creator,
    this.v,
  });

  WalletIds walletIds;
  String creatorDesc;
  int billsPaid;
  int billsRaised;
  int amountCollected;
  String amountCollectedDesc;
  DateTime lastPaidAt;
  int amountDue;
  bool isPrivate;
  String id;
  String name;
  String logo;
  String description;
  String documentHash;
  String email;
  String mobile;
  String code;
  String username;
  String bankId;
  int status;
  int creator;
  int v;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    walletIds: WalletIds.fromJson(json["wallet_ids"]),
    creatorDesc: json["creator_desc"],
    billsPaid: json["bills_paid"],
    billsRaised: json["bills_raised"],
    amountCollected: json["amount_collected"],
    amountCollectedDesc: json["amount_collected_desc"],
    lastPaidAt: DateTime.parse(json["last_paid_at"]),
    amountDue: json["amount_due"],
    isPrivate: json["is_private"],
    id: json["_id"],
    name: json["name"],
    logo: json["logo"],
    description: json["description"],
    documentHash: json["document_hash"],
    email: json["email"],
    mobile: json["mobile"],
    code: json["code"],
    username: json["username"],
    bankId: json["bank_id"],
    status: json["status"],
    creator: json["creator"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "wallet_ids": walletIds.toJson(),
    "creator_desc": creatorDesc,
    "bills_paid": billsPaid,
    "bills_raised": billsRaised,
    "amount_collected": amountCollected,
    "amount_collected_desc": amountCollectedDesc,
    "last_paid_at": lastPaidAt.toIso8601String(),
    "amount_due": amountDue,
    "is_private": isPrivate,
    "_id": id,
    "name": name,
    "logo": logo,
    "description": description,
    "document_hash": documentHash,
    "email": email,
    "mobile": mobile,
    "code": code,
    "username": username,
    "bank_id": bankId,
    "status": status,
    "creator": creator,
    "__v": v,
  };
}

class WalletIds {
  WalletIds({
    this.operational,
  });

  String operational;

  factory WalletIds.fromJson(Map<String, dynamic> json) => WalletIds(
    operational: json["operational"],
  );

  Map<String, dynamic> toJson() => {
    "operational": operational,
  };
}

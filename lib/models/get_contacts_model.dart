// To parse this JSON data, do
//
//     final getContactsResponseModel = getContactsResponseModelFromJson(jsonString);

import 'dart:convert';

GetContactsResponseModel getContactsResponseModelFromJson(String str) => GetContactsResponseModel.fromJson(json.decode(str));

String getContactsResponseModelToJson(GetContactsResponseModel data) => json.encode(data.toJson());

class GetContactsResponseModel {
  GetContactsResponseModel({
    this.status,
    this.message,
    this.contacts,
  });

  int status;
  String message;
  Contacts contacts;

  factory GetContactsResponseModel.fromJson(Map<String, dynamic> json) => GetContactsResponseModel(
    status: json["status"],
    message: json["message"],
    contacts: Contacts.fromJson(json["contacts"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "contacts": contacts.toJson(),
  };
}

class Contacts {
  Contacts({
    this.wallet,
    this.nonWallet,
  });

  List<Wallet> wallet;
  List<NonWallet> nonWallet;

  factory Contacts.fromJson(Map<String, dynamic> json) => Contacts(
    wallet: List<Wallet>.from(json["wallet"].map((x) => Wallet.fromJson(x))),
    nonWallet: List<NonWallet>.from(json["non_wallet"].map((x) => NonWallet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "wallet": List<dynamic>.from(wallet.map((x) => x.toJson())),
    "non_wallet": List<dynamic>.from(nonWallet.map((x) => x.toJson())),
  };
}

class NonWallet {
  NonWallet({
    this.id,
    this.name,
    this.lastName,
    this.mobile,
    this.email,
    this.country,
    this.v,
  });

  String id;
  String name;
  String lastName;
  String mobile;
  String email;
  String country;
  int v;

  factory NonWallet.fromJson(Map<String, dynamic> json) => NonWallet(
    id: json["_id"],
    name: json["name"],
    lastName: json["last_name"],
    mobile: json["mobile"],
    email: json["email"],
    country: json["country"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "last_name": lastName,
    "mobile": mobile,
    "email": email,
    "country": country,
    "__v": v,
  };
}

class Wallet {
  Wallet({
    this.id,
    this.name,
    this.mobile,
  });

  String id;
  String name;
  String mobile;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    id: json["_id"],
    name: json["name"],
    mobile: json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "mobile": mobile,
  };
}

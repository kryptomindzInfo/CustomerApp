// To parse this JSON data, do
//
//     final merchantDetailsResponseModel = merchantDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

MerchantDetailsResponseModel merchantDetailsResponseModelFromJson(String str) => MerchantDetailsResponseModel.fromJson(json.decode(str));

String merchantDetailsResponseModelToJson(MerchantDetailsResponseModel data) => json.encode(data.toJson());

class MerchantDetailsResponseModel {
  MerchantDetailsResponseModel({
    this.status,
    this.merchant,
    this.invoices,
  });

  int status;
  Merchant merchant;
  List<dynamic> invoices;

  factory MerchantDetailsResponseModel.fromJson(Map<String, dynamic> json) => MerchantDetailsResponseModel(
    status: json["status"],
    merchant: Merchant.fromJson(json["merchant"]),
    invoices: List<dynamic>.from(json["invoices"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "merchant": merchant.toJson(),
    "invoices": List<dynamic>.from(invoices.map((x) => x)),
  };
}

class Merchant {
  Merchant({
    this.id,
    this.name,
    this.logo,
    this.description,
    this.bankId,
  });

  String id;
  String name;
  String logo;
  String description;
  String bankId;

  factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
    id: json["_id"],
    name: json["name"],
    logo: json["logo"],
    description: json["description"],
    bankId: json["bank_id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "logo": logo,
    "description": description,
    "bank_id": bankId,
  };
}


MerchantDetailsRequestModel merchantDetailsRequestModelFromJson(String str) => MerchantDetailsRequestModel.fromJson(json.decode(str));

String merchantDetailsRequestModelToJson(MerchantDetailsRequestModel data) => json.encode(data.toJson());

class MerchantDetailsRequestModel {
  MerchantDetailsRequestModel({
    this.merchantId,
  });

  String merchantId;

  factory MerchantDetailsRequestModel.fromJson(Map<String, dynamic> json) => MerchantDetailsRequestModel(
    merchantId: json["merchant_id"],
  );

  Map<String, dynamic> toJson() => {
    "merchant_id": merchantId,
  };
}

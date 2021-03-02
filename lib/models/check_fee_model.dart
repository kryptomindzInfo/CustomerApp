// To parse this JSON data, do
//
//     final CheckFeeRequestModel = CheckFeeRequestModelFromJson(jsonString);

import 'dart:convert';

CheckFeeRequestModel CheckFeeRequestModelFromJson(String str) => CheckFeeRequestModel.fromJson(json.decode(str));

String CheckFeeRequestModelToJson(CheckFeeRequestModel data) => json.encode(data.toJson());

class CheckFeeRequestModel {
  CheckFeeRequestModel({
    this.amount,
    this.transType,
  });

  int amount;
  String transType;

  factory CheckFeeRequestModel.fromJson(Map<String, dynamic> json) => CheckFeeRequestModel(
    amount: json["amount"],
    transType: json["trans_type"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "trans_type": transType,
  };
}

// To parse this JSON data, do
//
//     final CheckFeeResponseModel = CheckFeeResponseModelFromJson(jsonString);



CheckFeeResponseModel CheckFeeResponseModelFromJson(String str) => CheckFeeResponseModel.fromJson(json.decode(str));

String CheckFeeResponseModelToJson(CheckFeeResponseModel data) => json.encode(data.toJson());

class CheckFeeResponseModel {
  CheckFeeResponseModel({
    this.status,
    this.message,
    this.fee,
  });

  int status;
  String message;
  double fee;

  factory CheckFeeResponseModel.fromJson(Map<String, dynamic> json) => CheckFeeResponseModel(
    status: json["status"],
    message: json["message"],
    fee: json["fee"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "fee": fee,
  };
}

// To parse this JSON data, do
//
//     final checkBillFeeRequestModel = checkBillFeeRequestModelFromJson(jsonString);

import 'dart:convert';

CheckBillFeeRequestModel checkBillFeeRequestModelFromJson(String str) => CheckBillFeeRequestModel.fromJson(json.decode(str));

String checkBillFeeRequestModelToJson(CheckBillFeeRequestModel data) => json.encode(data.toJson());

class CheckBillFeeRequestModel {
  CheckBillFeeRequestModel({
    this.merchantId,
    this.amount,
  });

  String merchantId;
  int amount;

  factory CheckBillFeeRequestModel.fromJson(Map<String, dynamic> json) => CheckBillFeeRequestModel(
    merchantId: json["merchant_id"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "merchant_id": merchantId,
    "amount": amount,
  };
}

// To parse this JSON data, do
//
//     final checkBillFeeResponseModel = checkBillFeeResponseModelFromJson(jsonString);


CheckBillFeeResponseModel checkBillFeeResponseModelFromJson(String str) => CheckBillFeeResponseModel.fromJson(json.decode(str));

String checkBillFeeResponseModelToJson(CheckBillFeeResponseModel data) => json.encode(data.toJson());

class CheckBillFeeResponseModel {
  CheckBillFeeResponseModel({
    this.status,
    this.message,
    this.fee,
  });

  int status;
  String message;
  double fee;

  factory CheckBillFeeResponseModel.fromJson(Map<String, dynamic> json) => CheckBillFeeResponseModel(
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

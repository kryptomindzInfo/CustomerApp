// To parse this JSON data, do
//
//     final sendMoneyToWalletRequestModel = sendMoneyToWalletRequestModelFromJson(jsonString);

import 'dart:convert';

SendMoneyToWalletRequestModel sendMoneyToWalletRequestModelFromJson(String str) => SendMoneyToWalletRequestModel.fromJson(json.decode(str));

String sendMoneyToWalletRequestModelToJson(SendMoneyToWalletRequestModel data) => json.encode(data.toJson());

class SendMoneyToWalletRequestModel {
  SendMoneyToWalletRequestModel({
    this.receiverMobile,
    this.note,
    this.sendingAmount,
  });

  String receiverMobile;
  String note;
  int sendingAmount;

  factory SendMoneyToWalletRequestModel.fromJson(Map<String, dynamic> json) => SendMoneyToWalletRequestModel(
    receiverMobile: json["receiverMobile"],
    note: json["note"],
    sendingAmount: json["sending_amount"],
  );

  Map<String, dynamic> toJson() => {
    "receiverMobile": receiverMobile,
    "note": note,
    "sending_amount": sendingAmount,
  };
}



SendMoneyToWalletResponseModel sendMoneyToWalletResponseModelFromJson(String str) => SendMoneyToWalletResponseModel.fromJson(json.decode(str));

String sendMoneyToWalletResponseModelToJson(SendMoneyToWalletResponseModel data) => json.encode(data.toJson());

class SendMoneyToWalletResponseModel {
  SendMoneyToWalletResponseModel({
    this.status,
    this.message,
    this.balance,
  });

  int status;
  String message;
  double balance;

  factory SendMoneyToWalletResponseModel.fromJson(Map<String, dynamic> json) => SendMoneyToWalletResponseModel(
    status: json["status"],
    message: json["message"],
    balance: json["balance"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "balance": balance,
  };
}

// To parse this JSON data, do
//
//     final sendMoneyToWalletRequestModel = sendMoneyToWalletRequestModelFromJson(jsonString);

import 'dart:convert';

SendMoneyToWalletRequestModel sendMoneyToWalletRequestModelFromJson(String str) => SendMoneyToWalletRequestModel.fromJson(json.decode(str));

String sendMoneyToWalletRequestModelToJson(SendMoneyToWalletRequestModel data) => json.encode(data.toJson());

class SendMoneyToWalletRequestModel {
  SendMoneyToWalletRequestModel({
    this.acceptedTerms,
    this.interbank,
    this.isInclusive,
    this.note,
    this.receiverMobile,
    this.sendingAmount,
  });

  bool acceptedTerms;
  bool interbank;
  bool isInclusive;
  String note;
  String receiverMobile;
  double sendingAmount;

  factory SendMoneyToWalletRequestModel.fromJson(Map<String, dynamic> json) => SendMoneyToWalletRequestModel(
    acceptedTerms: json["acceptedTerms"],
    interbank: json["interbank"],
    isInclusive: json["isInclusive"],
    note: json["note"],
    receiverMobile: json["receiverMobile"],
    sendingAmount: json["sending_amount"],
  );

  Map<String, dynamic> toJson() => {
    "acceptedTerms": acceptedTerms,
    "interbank": interbank,
    "isInclusive": isInclusive,
    "note": note,
    "receiverMobile": receiverMobile,
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
    this.transactionId
  });

  int status;
  String message;
  double balance;
  String transactionId;

  factory SendMoneyToWalletResponseModel.fromJson(Map<String, dynamic> json) => SendMoneyToWalletResponseModel(
    status: json["status"],
    message: json["message"],
    transactionId: json["transaction_code"],
    balance: json["balance"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "balance": balance,
  };
}

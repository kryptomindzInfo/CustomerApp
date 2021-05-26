// To parse this JSON data, do
//
//     final sendMoneyToNonWalletRequestModel = sendMoneyToNonWalletRequestModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

SendMoneyToNonWalletRequestModel sendMoneyToNonWalletRequestModelFromJson(String str) => SendMoneyToNonWalletRequestModel.fromJson(json.decode(str));

String sendMoneyToNonWalletRequestModelToJson(SendMoneyToNonWalletRequestModel data) => json.encode(data.toJson());

class SendMoneyToNonWalletRequestModel extends ChangeNotifier{
  SendMoneyToNonWalletRequestModel({
    this.acceptedTerms,
    this.ccode,
    this.interbank,
    this.isInclusive,
    this.note,
    this.receiverAddress,
    this.receiverCountry,
    this.receiverEmail,
    this.receiverFamilyName,
    this.receiverGivenName,
    this.receiverIdentificationAmount,
    this.receiverIdentificationCountry,
    this.receiverIdentificationNumber,
    this.receiverIdentificationType,
    this.receiverIdentificationValidTill,
    this.receiverMobile,
    this.receiverState,
    this.receiverZip,
    this.requireOtp,
    this.withoutId,
  });

  bool acceptedTerms;
  String ccode;
  bool interbank;
  bool isInclusive;
  String note;
  String receiverAddress;
  String receiverCountry;
  String receiverEmail;
  String receiverFamilyName;
  String receiverGivenName;
  int receiverIdentificationAmount;
  String receiverIdentificationCountry;
  int receiverIdentificationNumber;
  String receiverIdentificationType;
  String receiverIdentificationValidTill;
  String receiverMobile;
  String receiverState;
  String receiverZip;
  bool requireOtp;
  bool withoutId;

  factory SendMoneyToNonWalletRequestModel.fromJson(Map<String, dynamic> json) => SendMoneyToNonWalletRequestModel(
    acceptedTerms: json["acceptedTerms"],
    ccode: json["ccode"],
    interbank: json["interbank"],
    isInclusive: json["isInclusive"],
    note: json["note"],
    receiverAddress: json["receiverAddress"],
    receiverCountry: json["receiverCountry"],
    receiverEmail: json["receiverEmail"],
    receiverFamilyName: json["receiverFamilyName"],
    receiverGivenName: json["receiverGivenName"],
    receiverIdentificationAmount: json["receiverIdentificationAmount"],
    receiverIdentificationCountry: json["receiverIdentificationCountry"],
    receiverIdentificationNumber: json["receiverIdentificationNumber"],
    receiverIdentificationType: json["receiverIdentificationType"],
    receiverIdentificationValidTill: json["receiverIdentificationValidTill"],
    receiverMobile: json["receiverMobile"],
    receiverState: json["receiverState"],
    receiverZip: json["receiverZip"],
    requireOtp: json["requireOTP"],
    withoutId: json["withoutID"],
  );

  Map<String, dynamic> toJson() => {
    "acceptedTerms": acceptedTerms,
    "ccode": ccode,
    "interbank": interbank,
    "isInclusive": isInclusive,
    "note": note,
    "receiverAddress": receiverAddress,
    "receiverCountry": receiverCountry,
    "receiverEmail": receiverEmail,
    "receiverFamilyName": receiverFamilyName,
    "receiverGivenName": receiverGivenName,
    "receiverIdentificationAmount": receiverIdentificationAmount,
    "receiverIdentificationCountry": receiverIdentificationCountry,
    "receiverIdentificationNumber": receiverIdentificationNumber,
    "receiverIdentificationType": receiverIdentificationType,
    "receiverIdentificationValidTill": receiverIdentificationValidTill,
    "receiverMobile": receiverMobile,
    "receiverState": receiverState,
    "receiverZip": receiverZip,
    "requireOTP": requireOtp,
    "withoutID": withoutId,
  };
}



SendMoneyToNonWalletResponseModel sendMoneyToNonWalletResponseModelFromJson(String str) => SendMoneyToNonWalletResponseModel.fromJson(json.decode(str));

String sendMoneyToNonWalletResponseModelToJson(SendMoneyToNonWalletResponseModel data) => json.encode(data.toJson());

class SendMoneyToNonWalletResponseModel {
  SendMoneyToNonWalletResponseModel({
    this.status,
    this.message,
    this.balance,
    this.transactionId
  });

  int status;
  String message;
  String transactionId;
  double balance;

  factory SendMoneyToNonWalletResponseModel.fromJson(Map<String, dynamic> json) => SendMoneyToNonWalletResponseModel(
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

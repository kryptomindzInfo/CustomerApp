import 'dart:convert';

import 'package:flutter/cupertino.dart';

SendMoneyToNonWalletRequestModel sendMoneyToNonWalletRequestModelFromJson(String str) => SendMoneyToNonWalletRequestModel.fromJson(json.decode(str));

String sendMoneyToNonWalletRequestModelToJson(SendMoneyToNonWalletRequestModel data) => json.encode(data.toJson());

class SendMoneyToNonWalletRequestModel extends ChangeNotifier{
  SendMoneyToNonWalletRequestModel({
    this.note,
    this.withoutId,
    this.requireOtp,
    this.receiverMobile,
    this.receiverGivenName,
    this.receiverFamilyName,
    this.receiverCountry,
    this.receiverEmail,
    this.receiverIdentificationType,
    this.receiverIdentificationNumber,
    this.receiverIdentificationValidTill,
    this.sendingAmount,
  });

  String note;
  String withoutId;
  String requireOtp;
  String receiverMobile;
  String receiverGivenName;
  String receiverFamilyName;
  String receiverCountry;
  String receiverEmail;
  String receiverIdentificationType;
  String receiverIdentificationNumber;
  String receiverIdentificationValidTill;
  int sendingAmount;

  factory SendMoneyToNonWalletRequestModel.fromJson(Map<String, dynamic> json) => SendMoneyToNonWalletRequestModel(
    note: json["note"],
    withoutId: json["withoutID"],
    requireOtp: json["requireOTP"],
    receiverMobile: json["receiverMobile"],
    receiverGivenName: json["receiverGivenName"],
    receiverFamilyName: json["receiverFamilyName"],
    receiverCountry: json["receiverCountry"],
    receiverEmail: json["receiverEmail"],
    receiverIdentificationType: json["receiverIdentificationType"],
    receiverIdentificationNumber: json["receiverIdentificationNumber"],
    receiverIdentificationValidTill: json["receiverIdentificationValidTill"],
    sendingAmount: json["sending_amount"],
  );

  Map<String, dynamic> toJson() => {
    "note": note,
    "withoutID": withoutId,
    "requireOTP": requireOtp,
    "receiverMobile": receiverMobile,
    "receiverGivenName": receiverGivenName,
    "receiverFamilyName": receiverFamilyName,
    "receiverCountry": receiverCountry,
    "receiverEmail": receiverEmail,
    "receiverIdentificationType": receiverIdentificationType,
    "receiverIdentificationNumber": receiverIdentificationNumber,
    "receiverIdentificationValidTill": receiverIdentificationValidTill,
    "sending_amount": sendingAmount,
  };
}

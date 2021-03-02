import 'dart:convert';

GetBalanceResponseModel getBalanceResponseModelFromJson(String str) => GetBalanceResponseModel.fromJson(json.decode(str));

String getBalanceResponseModelToJson(GetBalanceResponseModel data) => json.encode(data.toJson());

class GetBalanceResponseModel {
  GetBalanceResponseModel({
    this.status,
    this.message,
    this.balance,
  });

  int status;
  String message;
  double balance;

  factory GetBalanceResponseModel.fromJson(Map<String, dynamic> json) => GetBalanceResponseModel(
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

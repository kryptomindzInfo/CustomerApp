import 'dart:convert';

AssignBankRequestModel assignBankRequestModelFromJson(String str) => AssignBankRequestModel.fromJson(json.decode(str));

String assignBankRequestModelToJson(AssignBankRequestModel data) => json.encode(data.toJson());

class AssignBankRequestModel {
  AssignBankRequestModel({
    this.bankId,
  });

  String bankId;

  factory AssignBankRequestModel.fromJson(Map<String, dynamic> json) => AssignBankRequestModel(
    bankId: json["bank_id"],
  );

  Map<String, dynamic> toJson() => {
    "bank_id": bankId,
  };
}

// To parse this JSON data, do
//
//     final assignBankResponseModel = assignBankResponseModelFromJson(jsonString);



AssignBankResponseModel assignBankResponseModelFromJson(String str) => AssignBankResponseModel.fromJson(json.decode(str));

String assignBankResponseModelToJson(AssignBankResponseModel data) => json.encode(data.toJson());

class AssignBankResponseModel {
  AssignBankResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory AssignBankResponseModel.fromJson(Map<String, dynamic> json) => AssignBankResponseModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}

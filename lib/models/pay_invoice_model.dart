// To parse this JSON data, do
//
//     final payInvoiceRequestModel = payInvoiceRequestModelFromJson(jsonString);

import 'dart:convert';

PayInvoiceRequestModel payInvoiceRequestModelFromJson(String str) => PayInvoiceRequestModel.fromJson(json.decode(str));

String payInvoiceRequestModelToJson(PayInvoiceRequestModel data) => json.encode(data.toJson());

class PayInvoiceRequestModel {
  PayInvoiceRequestModel({
    this.invoices,
    this.merchantId,
  });

  List<Invoice> invoices;
  String merchantId;

  factory PayInvoiceRequestModel.fromJson(Map<String, dynamic> json) => PayInvoiceRequestModel(
    invoices: List<Invoice>.from(json["invoices"].map((x) => Invoice.fromJson(x))),
    merchantId: json["merchant_id"],
  );

  Map<String, dynamic> toJson() => {
    "invoices": List<dynamic>.from(invoices.map((x) => x.toJson())),
    "merchant_id": merchantId,
  };
}

class Invoice {
  Invoice({
    this.id,
    this.penalty,
  });

  String id;
  int penalty;

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
    id: json["id"],
    penalty: json["penalty"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "penalty": penalty,
  };
}

// To parse this JSON data, do
//
//     final payInvoiceResponseModel = payInvoiceResponseModelFromJson(jsonString);


PayInvoiceResponseModel payInvoiceResponseModelFromJson(String str) => PayInvoiceResponseModel.fromJson(json.decode(str));

String payInvoiceResponseModelToJson(PayInvoiceResponseModel data) => json.encode(data.toJson());

class PayInvoiceResponseModel {
  PayInvoiceResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory PayInvoiceResponseModel.fromJson(Map<String, dynamic> json) => PayInvoiceResponseModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}

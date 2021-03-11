// To parse this JSON data, do
//
//     final getMerchantPenaltyRuleResponseModel = getMerchantPenaltyRuleResponseModelFromJson(jsonString);

import 'dart:convert';

GetMerchantPenaltyRuleResponseModel getMerchantPenaltyRuleResponseModelFromJson(String str) => GetMerchantPenaltyRuleResponseModel.fromJson(json.decode(str));

String getMerchantPenaltyRuleResponseModelToJson(GetMerchantPenaltyRuleResponseModel data) => json.encode(data.toJson());

class GetMerchantPenaltyRuleResponseModel {
  GetMerchantPenaltyRuleResponseModel({
    this.rule,
  });

  Rule rule;

  factory GetMerchantPenaltyRuleResponseModel.fromJson(Map<String, dynamic> json) => GetMerchantPenaltyRuleResponseModel(
    rule: Rule.fromJson(json["rule"]),
  );

  Map<String, dynamic> toJson() => {
    "rule": rule.toJson(),
  };
}

class Rule {
  Rule({
    this.type,
    this.percentage,
    this.fixedAmount,
  });

  String type;
  int percentage;
  int fixedAmount;

  factory Rule.fromJson(Map<String, dynamic> json) => Rule(
    type: json["type"],
    percentage: json["percentage"],
    fixedAmount: json["fixed_amount"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "percentage": percentage,
    "fixed_amount": fixedAmount,
  };
}

// To parse this JSON data, do
//
//     final getMerchantPenaltyRuleRequestModel = getMerchantPenaltyRuleRequestModelFromJson(jsonString);


GetMerchantPenaltyRuleRequestModel getMerchantPenaltyRuleRequestModelFromJson(String str) => GetMerchantPenaltyRuleRequestModel.fromJson(json.decode(str));

String getMerchantPenaltyRuleRequestModelToJson(GetMerchantPenaltyRuleRequestModel data) => json.encode(data.toJson());

class GetMerchantPenaltyRuleRequestModel {
  GetMerchantPenaltyRuleRequestModel({
    this.merchantId,
  });

  String merchantId;

  factory GetMerchantPenaltyRuleRequestModel.fromJson(Map<String, dynamic> json) => GetMerchantPenaltyRuleRequestModel(
    merchantId: json["merchant_id"],
  );

  Map<String, dynamic> toJson() => {
    "merchant_id": merchantId,
  };
}

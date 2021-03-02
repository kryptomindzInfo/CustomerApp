// To parse this JSON data, do
//
//     final getTransactionHistoryResponseModel = getTransactionHistoryResponseModelFromJson(jsonString);

import 'dart:convert';

GetTransactionHistoryResponseModel getTransactionHistoryResponseModelFromJson(String str) => GetTransactionHistoryResponseModel.fromJson(json.decode(str));

String getTransactionHistoryResponseModelToJson(GetTransactionHistoryResponseModel data) => json.encode(data.toJson());

class GetTransactionHistoryResponseModel {
  GetTransactionHistoryResponseModel({
    this.status,
    this.message,
    this.history,
  });

  int status;
  String message;
  List<History> history;

  factory GetTransactionHistoryResponseModel.fromJson(Map<String, dynamic> json) => GetTransactionHistoryResponseModel(
    status: json["status"],
    message: json["message"],
    history: List<History>.from(json["history"].map((x) => History.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "history": List<dynamic>.from(history.map((x) => x.toJson())),
  };
}

class History {
  History({
    this.txId,
    this.value,
    this.timestamp,
    this.isDelete,
  });

  String txId;
  Value value;
  String timestamp;
  String isDelete;

  factory History.fromJson(Map<String, dynamic> json) => History(
    txId: json["TxId"],
    value: Value.fromJson(json["Value"]),
    timestamp: json["Timestamp"],
    isDelete: json["IsDelete"],
  );

  Map<String, dynamic> toJson() => {
    "TxId": txId,
    "Value": value.toJson(),
    "Timestamp": timestamp,
    "IsDelete": isDelete,
  };
}

class Value {
  Value({
    this.walletId,
    this.walletType,
    this.amount,
    this.balance,
    this.remarks,
    this.action,
    this.txData,
  });

  String walletId;
  String walletType;
  double amount;
  double balance;
  String remarks;
  String action;
  TxData txData;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    walletId: json["wallet_id"],
    walletType: json["wallet_type"],
    amount: json["amount"].toDouble(),
    balance: json["balance"].toDouble(),
    remarks: json["remarks"],
    action: json["action"],
    txData: TxData.fromJson(json["tx_data"]),
  );

  Map<String, dynamic> toJson() => {
    "wallet_id": walletId,
    "wallet_type": walletType,
    "amount": amount,
    "balance": balance,
    "remarks": remarks,
    "action": action,
    "tx_data": txData.toJson(),
  };
}

class TxData {
  TxData({
    this.txId,
    this.masterId,
    this.childId,
    this.txType,
    this.txTimestamp,
    this.txDetails,
    this.userId,
  });

  String txId;
  String masterId;
  String childId;
  String txType;
  TxTimestamp txTimestamp;
  String txDetails;
  String userId;

  factory TxData.fromJson(Map<String, dynamic> json) => TxData(
    txId: json["tx_id"],
    masterId: json["master_id"],
    childId: json["child_id"],
    txType: json["tx_type"],
    txTimestamp: TxTimestamp.fromJson(json["tx_timestamp"]),
    txDetails: json["tx_details"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "tx_id": txId,
    "master_id": masterId,
    "child_id": childId,
    "tx_type": txType,
    "tx_timestamp": txTimestamp.toJson(),
    "tx_details": txDetails,
    "user_id": userId,
  };
}

class TxTimestamp {
  TxTimestamp({
    this.seconds,
    this.nanos,
  });

  int seconds;
  int nanos;

  factory TxTimestamp.fromJson(Map<String, dynamic> json) => TxTimestamp(
    seconds: json["seconds"],
    nanos: json["nanos"],
  );

  Map<String, dynamic> toJson() => {
    "seconds": seconds,
    "nanos": nanos,
  };
}

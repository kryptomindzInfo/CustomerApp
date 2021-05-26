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
    this.balance,
    this.action,
    this.userId,
    this.txData,
  });

  String walletId;
  String walletType;
  double balance;
  String action;
  String userId;
  List<TxDatum> txData;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    walletId: json["wallet_id"],
    walletType: json["wallet_type"],
    balance: json["balance"].toDouble(),
    action: json["action"],
    userId: json["user_id"],
    txData: List<TxDatum>.from(json["tx_data"].map((x) => TxDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "wallet_id": walletId,
    "wallet_type": walletType,
    "balance": balance,
    "action": action,
    "user_id": userId,
    "tx_data": List<dynamic>.from(txData.map((x) => x.toJson())),
  };
}

class TxDatum {
  TxDatum({
    this.txId,
    this.amount,
    this.masterId,
    this.childId,
    this.txType,
    this.txTimestamp,
    this.txDetails,
    this.remarks,
    this.txName,
  });

  String txId;
  double amount;
  String masterId;
  String childId;
  TxType txType;
  TxTimestamp txTimestamp;
  String txDetails;
  String remarks;
  String txName;

  factory TxDatum.fromJson(Map<String, dynamic> json) => TxDatum(
    txId: json["tx_id"],
    amount: json["amount"].toDouble(),
    masterId: json["master_id"],
    childId: json["child_id"],
    txType: txTypeValues.map[json["tx_type"]],
    txTimestamp: TxTimestamp.fromJson(json["tx_timestamp"]),
    txDetails: json["tx_details"],
    remarks: json["remarks"],
    txName: json["tx_name"],
  );

  Map<String, dynamic> toJson() => {
    "tx_id": txId,
    "amount": amount,
    "master_id": masterId,
    "child_id": childId,
    "tx_type": txTypeValues.reverse[txType],
    "tx_timestamp": txTimestamp.toJson(),
    "tx_details": txDetails,
    "remarks": remarks,
    "tx_name": txName,
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

enum TxType { EMPTY, CR, DR }

final txTypeValues = EnumValues({
  "CR": TxType.CR,
  "DR": TxType.DR,
  "": TxType.EMPTY
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

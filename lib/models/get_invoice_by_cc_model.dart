// To parse this JSON data, do
//
//     final getInvoiceByCcRequestModel = getInvoiceByCcRequestModelFromJson(jsonString);

import 'dart:convert';

GetInvoiceByCcRequestModel getInvoiceByCcRequestModelFromJson(String str) => GetInvoiceByCcRequestModel.fromJson(json.decode(str));

String getInvoiceByCcRequestModelToJson(GetInvoiceByCcRequestModel data) => json.encode(data.toJson());

class GetInvoiceByCcRequestModel {
  GetInvoiceByCcRequestModel({
    this.customerCode,
    this.merchantId,
  });

  String customerCode;
  String merchantId;

  factory GetInvoiceByCcRequestModel.fromJson(Map<String, dynamic> json) => GetInvoiceByCcRequestModel(
    customerCode: json["customer_code"],
    merchantId: json["merchant_id"],
  );

  Map<String, dynamic> toJson() => {
    "customer_code": customerCode,
    "merchant_id": merchantId,
  };
}




// To parse this JSON data, do
//
//     final getInvoiceByCcResponseModel = getInvoiceByCcResponseModelFromJson(jsonString);


GetInvoiceByCcResponseModel getInvoiceByCcResponseModelFromJson(String str) => GetInvoiceByCcResponseModel.fromJson(json.decode(str));

String getInvoiceByCcResponseModelToJson(GetInvoiceByCcResponseModel data) => json.encode(data.toJson());

class GetInvoiceByCcResponseModel {
  GetInvoiceByCcResponseModel({
    this.status,
    this.invoice,
  });

  int status;
  List<Invoice> invoice;

  factory GetInvoiceByCcResponseModel.fromJson(Map<String, dynamic> json) => GetInvoiceByCcResponseModel(
    status: json["status"],
    invoice: List<Invoice>.from(json["invoice"].map((x) => Invoice.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "invoice": List<dynamic>.from(invoice.map((x) => x.toJson())),
  };
}

class Invoice {
  Invoice({
    this.billPeriod,
    this.paid,
    this.paidDesc,
    this.isCreated,
    this.isValidated,
    this.isCounter,
    this.hasCounterInvoice,
    this.id,
    this.createdAt,
    this.items,
    this.number,
    this.name,
    this.lastName,
    this.address,
    this.amount,
    this.merchantId,
    this.billDate,
    this.dueDate,
    this.description,
    this.mobile,
    this.ccode,
    this.groupId,
    this.creatorId,
    this.customerCode,
    this.term,
    this.v,
    this.paidBy,
    this.payerId,
    this.penalty,
    this.transactionCode,
    this.datePaid,
  });

  BillPeriod billPeriod;
  int paid;
  PaidDesc paidDesc;
  int isCreated;
  int isValidated;
  bool isCounter;
  bool hasCounterInvoice;
  String id;
  DateTime createdAt;
  List<Item> items;
  String number;
  InvoiceName name;
  LastName lastName;
  Address address;
  int amount;
  String merchantId;
  String billDate;
  String dueDate;
  String description;
  String mobile;
  String ccode;
  GroupId groupId;
  CreatorId creatorId;
  String customerCode;
  int term;
  int v;
  PaidBy paidBy;
  PayerId payerId;
  int penalty;
  String transactionCode;
  DateTime datePaid;

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
    billPeriod: BillPeriod.fromJson(json["bill_period"]),
    paid: json["paid"],
    paidDesc: paidDescValues.map[json["paid_desc"]],
    isCreated: json["is_created"],
    isValidated: json["is_validated"],
    isCounter: json["is_counter"],
    hasCounterInvoice: json["has_counter_invoice"],
    id: json["_id"],
    createdAt: DateTime.parse(json["created_at"]),
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    number: json["number"],
    name: invoiceNameValues.map[json["name"]],
    lastName: lastNameValues.map[json["last_name"]],
    address: addressValues.map[json["address"]],
    amount: json["amount"],
    merchantId: json["merchant_id"],
    billDate: json["bill_date"],
    dueDate: json["due_date"],
    description: json["description"],
    mobile: json["mobile"],
    ccode: json["ccode"],
    groupId: groupIdValues.map[json["group_id"]],
    creatorId: creatorIdValues.map[json["creator_id"]],
    customerCode: json["customer_code"],
    term: json["term"],
    v: json["__v"],
    paidBy: json["paid_by"] == null ? null : paidByValues.map[json["paid_by"]],
    payerId: json["payer_id"] == null ? null : payerIdValues.map[json["payer_id"]],
    penalty: json["penalty"] == null ? null : json["penalty"],
    transactionCode: json["transaction_code"] == null ? null : json["transaction_code"],
    datePaid: json["date_paid"] == null ? null : DateTime.parse(json["date_paid"]),
  );

  Map<String, dynamic> toJson() => {
    "bill_period": billPeriod.toJson(),
    "paid": paid,
    "paid_desc": paidDescValues.reverse[paidDesc],
    "is_created": isCreated,
    "is_validated": isValidated,
    "is_counter": isCounter,
    "has_counter_invoice": hasCounterInvoice,
    "_id": id,
    "created_at": createdAt.toIso8601String(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "number": number,
    "name": invoiceNameValues.reverse[name],
    "last_name": lastNameValues.reverse[lastName],
    "address": addressValues.reverse[address],
    "amount": amount,
    "merchant_id": merchantIdValues.reverse[merchantId],
    "bill_date": billDate,
    "due_date": dueDate,
    "description": description,
    "mobile": mobile,
    "ccode": ccode,
    "group_id": groupIdValues.reverse[groupId],
    "creator_id": creatorIdValues.reverse[creatorId],
    "customer_code": customerCode,
    "term": term,
    "__v": v,
    "paid_by": paidBy == null ? null : paidByValues.reverse[paidBy],
    "payer_id": payerId == null ? null : payerIdValues.reverse[payerId],
    "penalty": penalty == null ? null : penalty,
    "transaction_code": transactionCode == null ? null : transactionCode,
    "date_paid": datePaid == null ? null : datePaid.toIso8601String(),
  };
}

enum Address { ITWARI, EMPTY }

final addressValues = EnumValues({
  "": Address.EMPTY,
  "itwari": Address.ITWARI
});

class BillPeriod {
  BillPeriod({
    this.startDate,
    this.endDate,
    this.periodName,
  });

  DateTime startDate;
  DateTime endDate;
  PeriodName periodName;

  factory BillPeriod.fromJson(Map<String, dynamic> json) => BillPeriod(
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    periodName: periodNameValues.map[json["period_name"]],
  );

  Map<String, dynamic> toJson() => {
    "start_date": startDate.toIso8601String(),
    "end_date": endDate.toIso8601String(),
    "period_name": periodNameValues.reverse[periodName],
  };
}

enum PeriodName { FEBRUARY, MARCH }

final periodNameValues = EnumValues({
  "February": PeriodName.FEBRUARY,
  "March": PeriodName.MARCH
});

enum CreatorId { THE_60388899_A489150007398_A6_A }

final creatorIdValues = EnumValues({
  "60388899a489150007398a6a": CreatorId.THE_60388899_A489150007398_A6_A
});

enum GroupId { THE_603889_AEA489150007398_A6_E }

final groupIdValues = EnumValues({
  "603889aea489150007398a6e": GroupId.THE_603889_AEA489150007398_A6_E
});

class Item {
  Item({
    this.id,
    this.itemDesc,
    this.quantity,
    this.taxDesc,
    this.totalAmount,
  });

  String id;
  ItemDesc itemDesc;
  int quantity;
  TaxDesc taxDesc;
  int totalAmount;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["_id"],
    itemDesc: ItemDesc.fromJson(json["item_desc"]),
    quantity: json["quantity"],
    taxDesc: TaxDesc.fromJson(json["tax_desc"]),
    totalAmount: json["total_amount"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "item_desc": itemDesc.toJson(),
    "quantity": quantity,
    "tax_desc": taxDesc.toJson(),
    "total_amount": totalAmount,
  };
}

class ItemDesc {
  ItemDesc({
    this.id,
    this.code,
    this.name,
    this.description,
    this.denomination,
    this.unitOfMeasure,
    this.unitPrice,
  });

  ItemDescId id;
  ItemDescCode code;
  ItemDescName name;
  Description description;
  Denomination denomination;
  UnitOfMeasure unitOfMeasure;
  int unitPrice;

  factory ItemDesc.fromJson(Map<String, dynamic> json) => ItemDesc(
    id: itemDescIdValues.map[json["_id"]],
    code: itemDescCodeValues.map[json["code"]],
    name: itemDescNameValues.map[json["name"]],
    description: descriptionValues.map[json["description"]],
    denomination: denominationValues.map[json["denomination"]],
    unitOfMeasure: unitOfMeasureValues.map[json["unit_of_measure"]],
    unitPrice: json["unit_price"],
  );

  Map<String, dynamic> toJson() => {
    "_id": itemDescIdValues.reverse[id],
    "code": itemDescCodeValues.reverse[code],
    "name": itemDescNameValues.reverse[name],
    "description": descriptionValues.reverse[description],
    "denomination": denominationValues.reverse[denomination],
    "unit_of_measure": unitOfMeasureValues.reverse[unitOfMeasure],
    "unit_price": unitPrice,
  };
}

enum ItemDescCode { PROD057, SERV057, PROD056, SERV056 }

final itemDescCodeValues = EnumValues({
  "prod056": ItemDescCode.PROD056,
  "prod057": ItemDescCode.PROD057,
  "serv056": ItemDescCode.SERV056,
  "serv057": ItemDescCode.SERV057
});

enum Denomination { THE_50_XOF }

final denominationValues = EnumValues({
  "50XOF": Denomination.THE_50_XOF
});

enum Description { DEMO_DESCRIPTION, DEMO2_DESCRIPTION }

final descriptionValues = EnumValues({
  "Demo2 description": Description.DEMO2_DESCRIPTION,
  "Demo description": Description.DEMO_DESCRIPTION
});

enum ItemDescId { THE_602612_E00023_D70007_F5749_E, THE_602612_E00023_D70007_F5749_F, THE_602612_E00023_D70007_F5749_C, THE_602612_E00023_D70007_F5749_D }

final itemDescIdValues = EnumValues({
  "602612e00023d70007f5749c": ItemDescId.THE_602612_E00023_D70007_F5749_C,
  "602612e00023d70007f5749d": ItemDescId.THE_602612_E00023_D70007_F5749_D,
  "602612e00023d70007f5749e": ItemDescId.THE_602612_E00023_D70007_F5749_E,
  "602612e00023d70007f5749f": ItemDescId.THE_602612_E00023_D70007_F5749_F
});

enum ItemDescName { PRODUCT57, SERVICE57, PRODUCT56, SERVICE56 }

final itemDescNameValues = EnumValues({
  "product56": ItemDescName.PRODUCT56,
  "product57": ItemDescName.PRODUCT57,
  "service56": ItemDescName.SERVICE56,
  "service57": ItemDescName.SERVICE57
});

enum UnitOfMeasure { XOF }

final unitOfMeasureValues = EnumValues({
  "XOF": UnitOfMeasure.XOF
});

class TaxDesc {
  TaxDesc({
    this.id,
    this.code,
    this.value,
  });

  TaxDescId id;
  TaxDescCode code;
  int value;

  factory TaxDesc.fromJson(Map<String, dynamic> json) => TaxDesc(
    id: taxDescIdValues.map[json["_id"]],
    code: taxDescCodeValues.map[json["code"]],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "_id": taxDescIdValues.reverse[id],
    "code": taxDescCodeValues.reverse[code],
    "value": value,
  };
}

enum TaxDescCode { TAX_GST, VAT_20 }

final taxDescCodeValues = EnumValues({
  "tax GST": TaxDescCode.TAX_GST,
  "VAT 20": TaxDescCode.VAT_20
});

enum TaxDescId { THE_602612_F20023_D70007_F574_A1, THE_602612_FB0023_D70007_F574_A2 }

final taxDescIdValues = EnumValues({
  "602612f20023d70007f574a1": TaxDescId.THE_602612_F20023_D70007_F574_A1,
  "602612fb0023d70007f574a2": TaxDescId.THE_602612_FB0023_D70007_F574_A2
});

enum LastName { DALAL, EMPTY }

final lastNameValues = EnumValues({
  "Dalal": LastName.DALAL,
  "": LastName.EMPTY
});

enum MerchantId { THE_6026121_C0023_D70007_F57497 }

final merchantIdValues = EnumValues({
  "6026121c0023d70007f57497": MerchantId.THE_6026121_C0023_D70007_F57497
});

enum InvoiceName { TAMIM }

final invoiceNameValues = EnumValues({
  "Tamim": InvoiceName.TAMIM
});

enum PaidBy { MC }

final paidByValues = EnumValues({
  "MC": PaidBy.MC
});

enum PaidDesc { THE_0_NOT_PAID_1_PAID }

final paidDescValues = EnumValues({
  "0-not paid 1-paid": PaidDesc.THE_0_NOT_PAID_1_PAID
});

enum PayerId { THE_602617_FF0023_D70007_F574_C3, THE_6043165_E4_C1_D34000779_BF6_D }

final payerIdValues = EnumValues({
  "602617ff0023d70007f574c3": PayerId.THE_602617_FF0023_D70007_F574_C3,
  "6043165e4c1d34000779bf6d": PayerId.THE_6043165_E4_C1_D34000779_BF6_D
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

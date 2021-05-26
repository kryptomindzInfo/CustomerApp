// To parse this JSON data, do
//
//     final getInvoiceByBillRequestModel = getInvoiceByBillRequestModelFromJson(jsonString);

import 'dart:convert';

GetInvoiceByBillRequestModel getInvoiceByBillRequestModelFromJson(String str) => GetInvoiceByBillRequestModel.fromJson(json.decode(str));

String getInvoiceByBillRequestModelToJson(GetInvoiceByBillRequestModel data) => json.encode(data.toJson());

class GetInvoiceByBillRequestModel {
  GetInvoiceByBillRequestModel({
    this.number,
    this.merchantId,
  });

  String number;
  String merchantId;

  factory GetInvoiceByBillRequestModel.fromJson(Map<String, dynamic> json) => GetInvoiceByBillRequestModel(
    number: json["number"],
    merchantId: json["merchant_id"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "merchant_id": merchantId,
  };
}

// To parse this JSON data, do
//
//     final getInvoiceByBillResponseModel = getInvoiceByBillResponseModelFromJson(jsonString);



GetInvoiceByBillResponseModel getInvoiceByBillResponseModelFromJson(String str) => GetInvoiceByBillResponseModel.fromJson(json.decode(str));

String getInvoiceByBillResponseModelToJson(GetInvoiceByBillResponseModel data) => json.encode(data.toJson());

class GetInvoiceByBillResponseModel {
  GetInvoiceByBillResponseModel({
    this.status,
    this.invoice,
  });

  int status;
  List<BillInvoice> invoice;

  factory GetInvoiceByBillResponseModel.fromJson(Map<String, dynamic> json) => GetInvoiceByBillResponseModel(
    status: json["status"],
    invoice: List<BillInvoice>.from(json["invoice"].map((x) => BillInvoice.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "invoice": List<dynamic>.from(invoice.map((x) => x.toJson())),
  };
}

class BillInvoice {
  BillInvoice({
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
    this.branchId,
    this.dueDate,
    this.description,
    this.mobile,
    this.ccode,
    this.groupId,
    this.creatorId,
    this.customerCode,
    this.term,
    this.v,
  });

  BillPeriod billPeriod;
  int paid;
  String paidDesc;
  int isCreated;
  int isValidated;
  bool isCounter;
  bool hasCounterInvoice;
  String id;
  DateTime createdAt;
  List<Item> items;
  String number;
  String name;
  String lastName;
  String address;
  int amount;
  String merchantId;
  String billDate;
  String branchId;
  String dueDate;
  String description;
  String mobile;
  String ccode;
  String groupId;
  String creatorId;
  String customerCode;
  int term;
  int v;

  factory BillInvoice.fromJson(Map<String, dynamic> json) => BillInvoice(
    billPeriod: BillPeriod.fromJson(json["bill_period"]),
    paid: json["paid"],
    paidDesc: json["paid_desc"],
    isCreated: json["is_created"],
    isValidated: json["is_validated"],
    isCounter: json["is_counter"],
    hasCounterInvoice: json["has_counter_invoice"],
    id: json["_id"],
    createdAt: DateTime.parse(json["created_at"]),
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    number: json["number"],
    name: json["name"],
    lastName: json["last_name"],
    address: json["address"],
    amount: json["amount"],
    merchantId: json["merchant_id"],
    billDate: json["bill_date"],
    branchId: json["branch_id"],
    dueDate: json["due_date"],
    description: json["description"],
    mobile: json["mobile"],
    ccode: json["ccode"],
    groupId: json["group_id"],
    creatorId: json["creator_id"],
    customerCode: json["customer_code"],
    term: json["term"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "bill_period": billPeriod.toJson(),
    "paid": paid,
    "paid_desc": paidDesc,
    "is_created": isCreated,
    "is_validated": isValidated,
    "is_counter": isCounter,
    "has_counter_invoice": hasCounterInvoice,
    "_id": id,
    "created_at": createdAt.toIso8601String(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "number": number,
    "name": name,
    "last_name": lastName,
    "address": address,
    "amount": amount,
    "merchant_id": merchantId,
    "bill_date": billDate,
    "branch_id": branchId,
    "due_date": dueDate,
    "description": description,
    "mobile": mobile,
    "ccode": ccode,
    "group_id": groupId,
    "creator_id": creatorId,
    "customer_code": customerCode,
    "term": term,
    "__v": v,
  };
}

class BillPeriod {
  BillPeriod({
    this.startDate,
    this.endDate,
    this.periodName,
  });

  DateTime startDate;
  DateTime endDate;
  String periodName;

  factory BillPeriod.fromJson(Map<String, dynamic> json) => BillPeriod(
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    periodName: json["period_name"],
  );

  Map<String, dynamic> toJson() => {
    "start_date": startDate.toIso8601String(),
    "end_date": endDate.toIso8601String(),
    "period_name": periodName,
  };
}

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

  String id;
  String code;
  String name;
  String description;
  String denomination;
  String unitOfMeasure;
  int unitPrice;

  factory ItemDesc.fromJson(Map<String, dynamic> json) => ItemDesc(
    id: json["_id"],
    code: json["code"],
    name: json["name"],
    description: json["description"],
    denomination: json["denomination"],
    unitOfMeasure: json["unit_of_measure"],
    unitPrice: json["unit_price"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "code": code,
    "name": name,
    "description": description,
    "denomination": denomination,
    "unit_of_measure": unitOfMeasure,
    "unit_price": unitPrice,
  };
}

class TaxDesc {
  TaxDesc({
    this.id,
    this.code,
    this.value,
  });

  String id;
  String code;
  int value;

  factory TaxDesc.fromJson(Map<String, dynamic> json) => TaxDesc(
    id: json["_id"],
    code: json["code"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "code": code,
    "value": value,
  };
}

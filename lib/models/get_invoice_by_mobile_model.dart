// To parse this JSON data, do
//
//     final getInvoiceByMobileRequestModel = getInvoiceByMobileRequestModelFromJson(jsonString);

import 'dart:convert';

GetInvoiceByMobileRequestModel getInvoiceByMobileRequestModelFromJson(String str) => GetInvoiceByMobileRequestModel.fromJson(json.decode(str));

String getInvoiceByMobileRequestModelToJson(GetInvoiceByMobileRequestModel data) => json.encode(data.toJson());

class GetInvoiceByMobileRequestModel {
  GetInvoiceByMobileRequestModel({
    this.mobile,
    this.merchantId,
  });

  String mobile;
  String merchantId;

  factory GetInvoiceByMobileRequestModel.fromJson(Map<String, dynamic> json) => GetInvoiceByMobileRequestModel(
    mobile: json["mobile"],
    merchantId: json["merchant_id"],
  );

  Map<String, dynamic> toJson() => {
    "mobile": mobile,
    "merchant_id": merchantId,
  };
}



class GetInvoiceByMobileResponseModel {
  int status;
  List<Invoices> invoices;

  GetInvoiceByMobileResponseModel({this.status, this.invoices});

  GetInvoiceByMobileResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['invoices'] != null) {
      invoices = new List<Invoices>();
      json['invoices'].forEach((v) {
        invoices.add(new Invoices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.invoices != null) {
      data['invoices'] = this.invoices.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Invoices {
  BillPeriod billPeriod;
  int paid;
  String paidDesc;
  int isCreated;
  int isValidated;
  bool isCounter;
  bool hasCounterInvoice;
  String sId;
  String createdAt;
  List<Items> items;
  String number;
  String name;
  String lastName;
  String address;
  int amount;
  String merchantId;
  String billDate;
  String dueDate;
  String description;
  String mobile;
  String ccode;
  String groupId;
  String creatorId;
  String customerCode;
  int term;
  int iV;
  String paidBy;
  String payerId;
  int penalty;
  String transactionCode;

  Invoices(
      {this.billPeriod,
        this.paid,
        this.paidDesc,
        this.isCreated,
        this.isValidated,
        this.isCounter,
        this.hasCounterInvoice,
        this.sId,
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
        this.iV,
        this.paidBy,
        this.payerId,
        this.penalty,
        this.transactionCode});

  Invoices.fromJson(Map<String, dynamic> json) {
    billPeriod = json['bill_period'] != null
        ? new BillPeriod.fromJson(json['bill_period'])
        : null;
    paid = json['paid'];
    paidDesc = json['paid_desc'];
    isCreated = json['is_created'];
    isValidated = json['is_validated'];
    isCounter = json['is_counter'];
    hasCounterInvoice = json['has_counter_invoice'];
    sId = json['_id'];
    createdAt = json['created_at'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    number = json['number'];
    name = json['name'];
    lastName = json['last_name'];
    address = json['address'];
    amount = json['amount'];
    merchantId = json['merchant_id'];
    billDate = json['bill_date'];
    dueDate = json['due_date'];
    description = json['description'];
    mobile = json['mobile'];
    ccode = json['ccode'];
    groupId = json['group_id'];
    creatorId = json['creator_id'];
    customerCode = json['customer_code'];
    term = json['term'];
    iV = json['__v'];
    paidBy = json['paid_by'];
    payerId = json['payer_id'];
    penalty = json['penalty'];
    transactionCode = json['transaction_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.billPeriod != null) {
      data['bill_period'] = this.billPeriod.toJson();
    }
    data['paid'] = this.paid;
    data['paid_desc'] = this.paidDesc;
    data['is_created'] = this.isCreated;
    data['is_validated'] = this.isValidated;
    data['is_counter'] = this.isCounter;
    data['has_counter_invoice'] = this.hasCounterInvoice;
    data['_id'] = this.sId;
    data['created_at'] = this.createdAt;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['number'] = this.number;
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    data['address'] = this.address;
    data['amount'] = this.amount;
    data['merchant_id'] = this.merchantId;
    data['bill_date'] = this.billDate;
    data['due_date'] = this.dueDate;
    data['description'] = this.description;
    data['mobile'] = this.mobile;
    data['ccode'] = this.ccode;
    data['group_id'] = this.groupId;
    data['creator_id'] = this.creatorId;
    data['customer_code'] = this.customerCode;
    data['term'] = this.term;
    data['__v'] = this.iV;
    data['paid_by'] = this.paidBy;
    data['payer_id'] = this.payerId;
    data['penalty'] = this.penalty;
    data['transaction_code'] = this.transactionCode;
    return data;
  }
}

class BillPeriod {
  String startDate;
  String endDate;
  String periodName;

  BillPeriod({this.startDate, this.endDate, this.periodName});

  BillPeriod.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    periodName = json['period_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['period_name'] = this.periodName;
    return data;
  }
}

class Items {
  String sId;
  ItemDesc itemDesc;
  int quantity;
  TaxDesc taxDesc;
  int totalAmount;

  Items(
      {this.sId, this.itemDesc, this.quantity, this.taxDesc, this.totalAmount});

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    itemDesc = json['item_desc'] != null
        ? new ItemDesc.fromJson(json['item_desc'])
        : null;
    quantity = json['quantity'];
    taxDesc = json['tax_desc'] != null
        ? new TaxDesc.fromJson(json['tax_desc'])
        : null;
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.itemDesc != null) {
      data['item_desc'] = this.itemDesc.toJson();
    }
    data['quantity'] = this.quantity;
    if (this.taxDesc != null) {
      data['tax_desc'] = this.taxDesc.toJson();
    }
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class ItemDesc {
  String sId;
  String code;
  String name;
  String description;
  String denomination;
  String unitOfMeasure;
  int unitPrice;

  ItemDesc(
      {this.sId,
        this.code,
        this.name,
        this.description,
        this.denomination,
        this.unitOfMeasure,
        this.unitPrice});

  ItemDesc.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    denomination = json['denomination'];
    unitOfMeasure = json['unit_of_measure'];
    unitPrice = json['unit_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['denomination'] = this.denomination;
    data['unit_of_measure'] = this.unitOfMeasure;
    data['unit_price'] = this.unitPrice;
    return data;
  }
}

class TaxDesc {
  String sId;
  String code;
  int value;

  TaxDesc({this.sId, this.code, this.value});

  TaxDesc.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    code = json['code'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['code'] = this.code;
    data['value'] = this.value;
    return data;
  }
}
class GetBanksResponseModel {
  int status;
  String message;
  List<Banks> banks;

  GetBanksResponseModel({this.status, this.message, this.banks});

  GetBanksResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['banks'] != null) {
      banks = new List<Banks>();
      json['banks'].forEach((v) {
        banks.add(new Banks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.banks != null) {
      data['banks'] = this.banks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banks {
  WalletIds walletIds;
  Null modifiedAt;
  bool initialSetup;
  int status;
  int totalTrans;
  String workingFrom;
  String workingTo;
  int totalBranches;
  int totalCashiers;
  int totalPartners;
  String sId;
  String createdAt;
  String name;
  String bcode;
  String address1;
  String state;
  String country;
  String zip;
  String ccode;
  String mobile;
  String username;
  String email;
  String userId;
  String logo;
  String contract;
  String password;
  int iV;

  Banks(
      {this.walletIds,
        this.modifiedAt,
        this.initialSetup,
        this.status,
        this.totalTrans,
        this.workingFrom,
        this.workingTo,
        this.totalBranches,
        this.totalCashiers,
        this.totalPartners,
        this.sId,
        this.createdAt,
        this.name,
        this.bcode,
        this.address1,
        this.state,
        this.country,
        this.zip,
        this.ccode,
        this.mobile,
        this.username,
        this.email,
        this.userId,
        this.logo,
        this.contract,
        this.password,
        this.iV});

  Banks.fromJson(Map<String, dynamic> json) {
    walletIds = json['wallet_ids'] != null
        ? new WalletIds.fromJson(json['wallet_ids'])
        : null;
    modifiedAt = json['modified_at'];
    initialSetup = json['initial_setup'];
    status = json['status'];
    totalTrans = json['total_trans'];
    workingFrom = json['working_from'];
    workingTo = json['working_to'];
    totalBranches = json['total_branches'];
    totalCashiers = json['total_cashiers'];
    totalPartners = json['total_partners'];
    sId = json['_id'];
    createdAt = json['created_at'];
    name = json['name'];
    bcode = json['bcode'];
    address1 = json['address1'];
    state = json['state'];
    country = json['country'];
    zip = json['zip'];
    ccode = json['ccode'];
    mobile = json['mobile'];
    username = json['username'];
    email = json['email'];
    userId = json['user_id'];
    logo = json['logo'];
    contract = json['contract'];
    password = json['password'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.walletIds != null) {
      data['wallet_ids'] = this.walletIds.toJson();
    }
    data['modified_at'] = this.modifiedAt;
    data['initial_setup'] = this.initialSetup;
    data['status'] = this.status;
    data['total_trans'] = this.totalTrans;
    data['working_from'] = this.workingFrom;
    data['working_to'] = this.workingTo;
    data['total_branches'] = this.totalBranches;
    data['total_cashiers'] = this.totalCashiers;
    data['total_partners'] = this.totalPartners;
    data['_id'] = this.sId;
    data['created_at'] = this.createdAt;
    data['name'] = this.name;
    data['bcode'] = this.bcode;
    data['address1'] = this.address1;
    data['state'] = this.state;
    data['country'] = this.country;
    data['zip'] = this.zip;
    data['ccode'] = this.ccode;
    data['mobile'] = this.mobile;
    data['username'] = this.username;
    data['email'] = this.email;
    data['user_id'] = this.userId;
    data['logo'] = this.logo;
    data['contract'] = this.contract;
    data['password'] = this.password;
    data['__v'] = this.iV;
    return data;
  }
}

class WalletIds {
  String operational;
  String master;
  String escrow;
  String infraOperational;
  String infraMaster;

  WalletIds(
      {this.operational,
        this.master,
        this.escrow,
        this.infraOperational,
        this.infraMaster});

  WalletIds.fromJson(Map<String, dynamic> json) {
    operational = json['operational'];
    master = json['master'];
    escrow = json['escrow'];
    infraOperational = json['infra_operational'];
    infraMaster = json['infra_master'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['operational'] = this.operational;
    data['master'] = this.master;
    data['escrow'] = this.escrow;
    data['infra_operational'] = this.infraOperational;
    data['infra_master'] = this.infraMaster;
    return data;
  }
}
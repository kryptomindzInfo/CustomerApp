import 'dart:convert';

GetUserDetailsResponseModel getUserDetailsResponseModelFromJson(String str) => GetUserDetailsResponseModel.fromJson(json.decode(str));

String getUserDetailsResponseModelToJson(GetUserDetailsResponseModel data) => json.encode(data.toJson());

class GetUserDetailsResponseModel {
  GetUserDetailsResponseModel({
    this.status,
    this.message,
    this.user,
  });

  int status;
  String message;
  User user;

  factory GetUserDetailsResponseModel.fromJson(Map<String, dynamic> json) => GetUserDetailsResponseModel(
    status: json["status"],
    message: json["message"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "user": user.toJson(),
  };
}

class User {
  User({
    this.bankId,
    this.status,
    this.statusDesc,
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.address,
    this.username,
    this.v,
    this.country,
    this.idName,
    this.idNumber,
    this.idType,
    this.lastName,
    this.state,
    this.validTill,
    this.walletId,
    this.messages,
  });

  String bankId;
  int status;
  String statusDesc;
  String id;
  String name;
  String mobile;
  String email;
  String address;
  String username;
  int v;
  String country;
  String idName;
  String idNumber;
  String idType;
  String lastName;
  String state;
  String validTill;
  String walletId;
  List<dynamic> messages;

  factory User.fromJson(Map<String, dynamic> json) => User(
    bankId: json["bank_id"],
    status: json["status"],
    statusDesc: json["status_desc"],
    id: json["_id"],
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    address: json["address"],
    username: json["username"],
    v: json["__v"],
    country: json["country"],
    idName: json["id_name"],
    idNumber: json["id_number"],
    idType: json["id_type"],
    lastName: json["last_name"],
    state: json["state"],
    validTill: json["valid_till"],
    walletId: json["wallet_id"],
    messages: List<dynamic>.from(json["messages"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "bank_id": bankId,
    "status": status,
    "status_desc": statusDesc,
    "_id": id,
    "name": name,
    "mobile": mobile,
    "email": email,
    "address": address,
    "username": username,
    "__v": v,
    "country": country,
    "id_name": idName,
    "id_number": idNumber,
    "id_type": idType,
    "last_name": lastName,
    "state": state,
    "valid_till": validTill,
    "wallet_id": walletId,
    "messages": List<dynamic>.from(messages.map((x) => x)),
  };
}


GetUserDetailsRequestModel getUserDetailsRequestModelFromJson(String str) => GetUserDetailsRequestModel.fromJson(json.decode(str));

String getUserDetailsRequestModelToJson(GetUserDetailsRequestModel data) => json.encode(data.toJson());

class GetUserDetailsRequestModel {
  GetUserDetailsRequestModel({
    this.mobile,
  });

  String mobile;

  factory GetUserDetailsRequestModel.fromJson(Map<String, dynamic> json) => GetUserDetailsRequestModel(
    mobile: json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "mobile": mobile,
  };
}

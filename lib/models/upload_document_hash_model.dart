import 'dart:convert';

class UploadDocsHashRequestModel {
  List<Hashes> hashes;

  UploadDocsHashRequestModel({this.hashes});

  UploadDocsHashRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['hashes'] != null) {
      hashes = new List<Hashes>();
      json['hashes'].forEach((v) {
        hashes.add(new Hashes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hashes != null) {
      data['hashes'] = this.hashes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hashes {
  String name;
  String hash;
  String type;

  Hashes({this.name, this.hash, this.type});

  Hashes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    hash = json['hash'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['hash'] = this.hash;
    data['type'] = this.type;
    return data;
  }
}

UploadDocsHashResponseModel uploadDocsHashResponseModelFromJson(String str) => UploadDocsHashResponseModel.fromJson(json.decode(str));

String uploadDocsHashResponseModelToJson(UploadDocsHashResponseModel data) => json.encode(data.toJson());

class UploadDocsHashResponseModel {
  UploadDocsHashResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory UploadDocsHashResponseModel.fromJson(Map<String, dynamic> json) => UploadDocsHashResponseModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}

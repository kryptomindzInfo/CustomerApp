class HeaderModel{
  String authorization;
  HeaderModel({this.authorization});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'Authorization': authorization,
    };
    return map;
  }
}
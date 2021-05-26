import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var inputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(
    horizontal: 12.0,
    vertical: 6.0,
  ),
  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor, width: 1.5)),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
  ),
  counter: Offstage(),
  labelText: '',
);

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

final startColor = Color(0xff000000);
final endColor = Color(0xff166D3B);
final primaryColor = Color(0xff417505);
final balanceTileColor = Colors.deepOrange;

const String imageBaseURL = "http://91d90ac373dc.sn.mynetname.net:40301/api/uploads/";
const String baseURL = "http://91d90ac373dc.sn.mynetname.net:40301/api/";
const String docBaseUrl = "http://91d90ac373dc.sn.mynetname.net:40880/ipfs/";

String getDateForSuccessScreen(DateTime dateTime){
  var outputFormat = DateFormat('dd/MM/yyyy hh:mm a');
  String outputDate = outputFormat.format(dateTime);
  return outputDate;
}
String convertDateTime(DateTime datetime){
  var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
  String outputDate = outputFormat.format(datetime.add(Duration(hours: 5,minutes: 30)).toLocal());
  return outputDate;
}
import 'package:beyond_wallet/constants/constants.dart';
import 'package:flutter/material.dart';


Widget appBar(String text,BuildContext context,bool goBack){
  return new PreferredSize(
    child: new Container(
      width: double.infinity,
      padding: new EdgeInsets.only(
          top: MediaQuery.of(context).padding.top
      ),
      child: new Padding(
        padding: const EdgeInsets.only(
            left: 10.0,
            top: 20.0,
            bottom: 20.0
        ),
        child: Row(
          children: [
            goBack?InkWell(
              onTap:(){
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ):Offstage(),
            SizedBox(width: 10.0,),
            new Text(
              text,
              style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
              ),
            ),
          ],
        ),
      ),
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                endColor,
                startColor,
              ]
          ),
          boxShadow: [
            new BoxShadow(
              color: Colors.grey[500],
              blurRadius: 20.0,
              spreadRadius: 1.0,
            )
          ]
      ),
    ),
    preferredSize: new Size(
        MediaQuery.of(context).size.width,
        150.0
    ),
  );
}
import 'package:beyond_wallet/constants/constants.dart';
import 'package:flutter/material.dart';
class GreenButton extends StatelessWidget {
  final String text;
  final Function onClicked;
  GreenButton({this.text, this.onClicked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked,
      child: Container(
        width: double.infinity,
        height: 60.0,
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}

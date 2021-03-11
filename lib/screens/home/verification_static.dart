import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/widgets/appBar.dart';
import 'package:flutter/material.dart';
class VerificationStatic extends StatefulWidget {
  final String text;
  VerificationStatic({this.text});

  @override
  _VerificationStaticState createState() => _VerificationStaticState();
}

class _VerificationStaticState extends State<VerificationStatic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          'Verification Pending',
          context
          ,false
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: Icon(
                  Icons.pending,
                  size: 50.0,
                ),
                title: Text(
                    widget.text,
                  style: TextStyle(
                    fontSize: 21.0
                  ),
                ),
              ),
              SizedBox(height: 40.0,),
              RaisedButton(
                onPressed: (){},
                color: primaryColor,
                child: Text(
                  'Check Verification',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/widgets/appBar.dart';
import 'package:beyond_wallet/localization/localization.dart';
import 'package:beyond_wallet/widgets/button.dart';
import 'package:flutter/material.dart';
class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    var translate = DemoLocalization.of(context);
    return Scaffold(
      appBar: appBar(translate.getTranslatedValue('Forgot Password'), context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              maxLength: 15,
              keyboardType:TextInputType.numberWithOptions(
                decimal: true,
              ) ,
              validator: (val) =>
              val.isEmpty || val.length<10
                  ? translate.getTranslatedValue('Invalid Mobile Number')
                  : null,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20.0
              ),
              onChanged: (val) {
                //loginRequestModel.mobileNo=val;
              },
              decoration: inputDecoration.copyWith(labelText: translate.getTranslatedValue('Mobile Number')),

            ),
            SizedBox(height: 15.0,),
            GreenButton(
              text: translate.getTranslatedValue('Get Password'),
              onClicked: (){},
            ),
          ],
        ),
      ),
    );
  }
}

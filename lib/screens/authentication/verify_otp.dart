import 'package:beyond_wallet/api_services/sign_up_api.dart';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/sign_up_model.dart';
import 'package:beyond_wallet/widgets/Loader.dart';
import 'package:beyond_wallet/widgets/appBar.dart';
import 'package:beyond_wallet/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'login.dart';


class VerifyOtp extends StatefulWidget {

  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {

  String code = "";
  bool isApiCallProcess=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var signUpData = Provider.of<SignUpRequestModel>(context);
    return isApiCallProcess?Loader():Scaffold(
      appBar: appBar('Verify OTP', context,true),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 30.0,),
              TextFormField(
                obscureText: true,
                validator: (val) =>
                val.isEmpty || val.length<6
                    ? 'Invalid OTP'
                    : null,
                onChanged: (val) {
                  setState(() {
                    code = val;
                  });
                },
                decoration:inputDecoration.copyWith(labelText: 'Enter OTP'),

              ),
              SizedBox(height: 30.0,),
              GreenButton(
                text: 'Submit',
                onClicked: () async {
                  if(_formKey.currentState.validate()){
                    signUpData.otp = code;
                    setState(() {
                      isApiCallProcess= true;
                    });
                    SignUpResponseModel response =await SignUpApi().signUp(signUpData);
                    setState(() {
                      isApiCallProcess = false;
                    });
                    if(response!=null){
                      Fluttertoast.showToast(msg: response.message);
                      if(response.status==1){
                        Navigator.of(context)
                            .pushAndRemoveUntil(MaterialPageRoute(
                            builder: (context)=>Login()
                        ), (Route<dynamic> route) => false);
                      }
                    }else{
                      Fluttertoast.showToast(msg: 'Something went Wrong');
                    }
                  }
                },
              )
            ],
          ),
        ),
      )
    );
  }
}
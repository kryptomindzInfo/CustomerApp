import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/controller/verify_otp_controller.dart';
import 'package:beyond_wallet/localization/localization.dart';
import 'package:beyond_wallet/models/sign_up_model.dart';
import 'package:beyond_wallet/models/verify_otp_model.dart';
import 'package:beyond_wallet/screens/authentication/verify_otp.dart';
import 'package:beyond_wallet/widgets/Loader.dart';
import 'package:beyond_wallet/widgets/appBar.dart';
import 'package:beyond_wallet/widgets/button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool agreeTandC = false;
  final _formKey = GlobalKey<FormState>();
  bool isApiCallProgress = false;

  @override
  Widget build(BuildContext context) {
    var signUpData = Provider.of<SignUpRequestModel>(context);
    var translate = DemoLocalization.of(context);
    return isApiCallProgress?Loader():Scaffold(
      appBar: appBar(translate.getTranslatedValue("Sign Up"),context,true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10.0,),
                Text(
                  translate.getTranslatedValue("Create new account"),
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w400
                  ),
                ),
                Text(
                  translate.getTranslatedValue("Use your Mobile Number to create new account... it's free"),
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 40.0,),
                TextFormField(
                  validator: (val) =>
                  val.length<2
                      ? 'Enter Valid Name'
                      : null,
                  style: TextStyle(
                      color: Colors.black87,
                  ),
                  onChanged: (val) {
                    signUpData.name = val;
                  },
                  decoration: inputDecoration.copyWith(labelText: translate.getTranslatedValue("Given Name")),
                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  validator: (val) =>
                  val.length<10
                      ? translate.getTranslatedValue('Invalid Family Name')
                      : null,
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                  onChanged: (val) {
                    signUpData.address = val;
                  },
                  decoration: inputDecoration.copyWith(labelText: translate.getTranslatedValue("Family Name")),

                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  maxLength: 15,
                  keyboardType:TextInputType.numberWithOptions(
                    decimal: true,
                  ) ,
                  validator: (val) =>
                  val.isEmpty || val.length<10
                      ? 'Mobile Number Invalid'
                      : null,
                  style: TextStyle(
                      color: Colors.black87,
                  ),
                  onChanged: (val) {
                    signUpData.mobile = val;
                  },
                  decoration: inputDecoration.copyWith(labelText: translate.getTranslatedValue("Mobile Number")),

                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  validator: (input) => input.isValidEmail() ? null : "Check your email",
                  style: TextStyle(
                      color: Colors.black87,
                  ),
                  onChanged: (val) {
                    signUpData.email = val;
                  },
                  decoration: inputDecoration.copyWith(labelText: translate.getTranslatedValue("Email Address")),

                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  obscureText: true,
                  validator: (val) =>
                  val.isEmpty || val.length<6
                      ? translate.getTranslatedValue('enter valid password')
                      : null,
                  style: TextStyle(
                      color: Colors.black87,
                  ),
                  onChanged: (val) {
                    signUpData.password = val;
                  },
                  decoration:inputDecoration.copyWith(labelText: translate.getTranslatedValue("Password")),
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: agreeTandC,
                      onChanged: (val){
                        setState(() {
                          agreeTandC =  val;
                        });
                      },
                    ),
                    RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                                text: translate.getTranslatedValue("I have read the"),
                                style: TextStyle(
                                    color: Colors.black54
                                )
                            ),
                            TextSpan(
                                text: translate.getTranslatedValue("Terms and Conditions"),
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pop(context);
                                  }
                            ),
                          ]
                      ),
                    )
                  ],
                ),
                GreenButton(
                  text: translate.getTranslatedValue('Sign Up'),
                  onClicked: ()async{
                    if(_formKey.currentState.validate()){
                      if(agreeTandC){
                        setState(() {
                          isApiCallProgress = true;
                        });
                        VerifyOtpResponseModel response =await VerifyOtpController().verifyOtp(signUpData.mobile, signUpData.email);
                        setState(() {
                          isApiCallProgress = false;
                        });
                        if(response!=null){
                          Fluttertoast.showToast(msg: response.message);
                          if(response.status==1){
                            Navigator.push(context, new MaterialPageRoute(builder: (context)=>VerifyOtp()));
                          }
                        }else{
                          Fluttertoast.showToast(msg: 'Something went wrong');

                        }
                      }else{
                        Fluttertoast.showToast(msg: 'Please Agree The Terms');
                      }
                    }
                  },
                ),
                SizedBox(height: 10.0,),
                RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                            text: translate.getTranslatedValue("Have an account?"),
                            style: TextStyle(
                                color: Colors.black54
                            )
                        ),
                        TextSpan(
                            text: translate.getTranslatedValue("Sign In"),
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                              }
                        ),
                      ]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

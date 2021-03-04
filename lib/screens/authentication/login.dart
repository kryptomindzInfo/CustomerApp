import 'package:beyond_wallet/api_services/login_api.dart';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/controller/balance_controller.dart';
import 'package:beyond_wallet/controller/get_banks_controller.dart';
import 'package:beyond_wallet/models/login_model.dart';
import 'package:beyond_wallet/screens/home/home_screen.dart';
import 'package:beyond_wallet/screens/home/select_bank.dart';
import 'package:beyond_wallet/screens/home/verification_static.dart';
import 'package:beyond_wallet/services/shared_prefs.dart';
import 'package:beyond_wallet/widgets/Loader.dart';
import 'package:beyond_wallet/widgets/appBar.dart';
import 'package:beyond_wallet/localization/localization.dart';
import 'package:beyond_wallet/screens/authentication/forgot_password.dart';
import 'package:beyond_wallet/screens/authentication/sign_up.dart';
import 'package:beyond_wallet/widgets/button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String mobile;
  String password;
  bool isApiCallProgress = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var translate = DemoLocalization.of(context);
    var _localData = Provider.of<LocalData>(context);
    return isApiCallProgress?Loader():Scaffold(
      appBar: appBar(translate.getTranslatedValue("Login"),context),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
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
                onChanged: (val) {
                  setState(() {
                    mobile = val;
                  });
                },
                decoration: inputDecoration.copyWith(labelText: translate.getTranslatedValue('Mobile Number')),

              ),
              SizedBox(height: 15.0,),
              TextFormField(
                obscureText: true,
                validator: (val) =>
                val.isEmpty
                    ? translate.getTranslatedValue('Invalid Password')
                    : null,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                decoration:inputDecoration.copyWith(labelText: translate.getTranslatedValue("Password")),

              ),
              SizedBox(height: 50.0,),
              GreenButton(
                  text: translate.getTranslatedValue('Login'),
                onClicked: _login(_localData,context)
              ),
              SizedBox(height: 40.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                              text: translate.getTranslatedValue("Don't Have an account? "),
                              style: TextStyle(
                                  color: Colors.black54
                              )
                          ),
                          TextSpan(
                              text: translate.getTranslatedValue("Sign Up"),
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          SignUp()));
                                }
                          ),
                        ]
                    ),
                  ),
                  GestureDetector(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword())),
                    child: Text(
                        translate.getTranslatedValue('Forgot Password'),
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Function _login(LocalData localData, BuildContext context){
    BalanceController getBalance = Provider.of<BalanceController>(context);

    return ()async{
      if(_formKey.currentState.validate()){
        LoginRequestModel request = new LoginRequestModel();
        request.username = mobile;
        request.password = password;
        setState(() {
          isApiCallProgress = true;
        });
        LoginResponseModel response =await LoginApi().login(request);
        if(response!=null){
          if(response.status==1){
            Fluttertoast.showToast(msg: 'Login Success');
            await localData.saveToSharedPrefs(response.user, response.token);
            localData.getFromSharedPrefs();
            setState(() {
              isApiCallProgress = false;
            });
            switch(response.user.status){
              case 0:
                Get.to(()=>SelectBank());
                break;
              case 1:
                getBalance.getBalanceController(response.token);
                Get.offAll(()=>HomeScreen());
                break;
              case 2:
                Get.to(()=>VerificationStatic(text:'Waiting for cashier approval'));
                break;
              case 3:
                Get.to(()=>VerificationStatic(text: 'Go to the nearest branch and get docs uploaded'));
                break;
            }
          }else{
            setState(() {
              isApiCallProgress = false;
            });
            Fluttertoast.showToast(msg: 'Login Failed!');
          }
        }else{
          setState(() {
            isApiCallProgress = false;
          });
          Fluttertoast.showToast(msg: 'Mobile or Password is Incorrect');
        }
      }
    };
  }
}

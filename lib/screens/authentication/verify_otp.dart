import 'package:beyond_wallet/api_services/sign_up_api.dart';
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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var signUpData = Provider.of<SignUpRequestModel>(context);
    return isApiCallProcess?Loader():Scaffold(
      appBar: appBar('Verify OTP', context),
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          'Code Sent To 9691650252',
                          style: TextStyle(
                            fontSize: 22,
                            color: Color(0xFF818181),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            buildCodeNumberBox(code.length > 0 ? code.substring(0, 1) : "", width * 0.12),
                            buildCodeNumberBox(code.length > 1 ? code.substring(1, 2) : "", width * 0.12),
                            buildCodeNumberBox(code.length > 2 ? code.substring(2, 3) : "", width * 0.12),
                            buildCodeNumberBox(code.length > 3 ? code.substring(3, 4) : "", width * 0.12),
                            buildCodeNumberBox(code.length > 4 ? code.substring(4, 5) : "", width * 0.12),
                            buildCodeNumberBox(code.length > 5 ? code.substring(5, 6) : "", width * 0.12),

                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Text(
                              "didn't receive code ",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF818181),
                              ),
                            ),

                            SizedBox(
                              width: 8,
                            ),

                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isApiCallProcess = true;
                                });
                              },
                              child: Text(
                               'Request Again',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: <Widget>[

                      Expanded(
                          child: GreenButton(
                            onClicked: () async {
                              if(code.length == 6){
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
                            text: 'Proceed',
                          )
                      ),

                    ],
                  ),
                ),
              ),

              NumericPad(
                onNumberSelected: (value) {
                  setState(() {
                    if(value != -1){
                      if(code.length < 6){
                        code = code + value.toString();
                      }
                    }
                    else{
                      code = code.substring(0, code.length - 1);
                    }
                  });
                },
              ),

            ],
          )
      ),
    );
  }

  Widget buildCodeNumberBox(String codeNumber,double size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        width: size,
        height: size,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF6F5FA),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 25.0,
                  spreadRadius: 1,
                  offset: Offset(0.0, 0.75)
              )
            ],
          ),
          child: Center(
            child: Text(
              codeNumber,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class NumericPad extends StatelessWidget {

  final Function(int) onNumberSelected;

  NumericPad({@required this.onNumberSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

          Container(
            height: MediaQuery.of(context).size.height * 0.11,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNumber(1),
                buildNumber(2),
                buildNumber(3),
              ],
            ),
          ),

          Container(
            height: MediaQuery.of(context).size.height * 0.11,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNumber(4),
                buildNumber(5),
                buildNumber(6),
              ],
            ),
          ),

          Container(
            height: MediaQuery.of(context).size.height * 0.11,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNumber(7),
                buildNumber(8),
                buildNumber(9),
              ],
            ),
          ),

          Container(
            height: MediaQuery.of(context).size.height * 0.11,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildEmptySpace(),
                buildNumber(0),
                buildBackspace(),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget buildNumber(int number) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onNumberSelected(number);
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F1F1F),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBackspace() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onNumberSelected(-1);
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.backspace,
                size: 28,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmptySpace() {
    return Expanded(
      child: Container(),
    );
  }

}
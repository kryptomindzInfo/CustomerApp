import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/services/shared_prefs.dart';
import 'package:beyond_wallet/utils/network_util.dart';
import 'package:beyond_wallet/widgets/appBar.dart';
import 'package:beyond_wallet/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String password;
  String confirmedPassword;
  final formKey = GlobalKey<FormState>();
  LocalData _localData;
  String error;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _localData = Provider.of<LocalData>(context,listen: false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Change Password', context, true),
      body: Container(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                TextFormField(
                  obscureText: true,
                  onChanged: (val)=> setState((){
                    password=val;
                  }),
                  validator: (val) =>
                  val.length<2
                      ? 'Enter Valid Password'
                      : null,
                  decoration: inputDecoration.copyWith(
                      labelText: 'New Password'
                  ),
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  obscureText: true,
                  validator: (val) =>
                  val.length<2
                      ? 'Enter Valid Password'
                      : password != confirmedPassword ? "Passwords Don't Match" : null,
                  onChanged: (val)=> setState((){
                    confirmedPassword=val;
                  }),
                  decoration: inputDecoration.copyWith(
                      labelText: 'Confirm Password'
                  ),
                ),
                SizedBox(height: 20.0,),
                GreenButton(
                  text: 'Reset',
                  onClicked: () async {
                    if(formKey.currentState.validate()){
                      Map response = await NetworkUtil.httpPostComplex({
                        'password' : password,
                        'username' : _localData.data.mobile
                      }, 'user/updatePassword',context);
                      if(response['status']==1){
                        Navigator.pop(context);
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

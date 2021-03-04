import 'package:beyond_wallet/api_services/check_fee_api.dart';
import 'package:beyond_wallet/api_services/get_user_details_api.dart';
import 'package:beyond_wallet/api_services/send_money_to_wallet_api.dart';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/controller/balance_controller.dart';
import 'package:beyond_wallet/localization/localization.dart';
import 'package:beyond_wallet/models/check_fee_model.dart';
import 'package:beyond_wallet/models/get_user_details_model.dart';
import 'package:beyond_wallet/models/send_money_to_wallet_model.dart';
import 'package:beyond_wallet/services/shared_prefs.dart';
import 'package:beyond_wallet/widgets/Loader.dart';
import 'package:beyond_wallet/widgets/button.dart';
import 'package:beyond_wallet/widgets/sucess_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
class SendMoneyToWallet extends StatefulWidget {
  @override
  _SendMoneyToWalletState createState() => _SendMoneyToWalletState();
}

class _SendMoneyToWalletState extends State<SendMoneyToWallet> {
  final _formKey = GlobalKey<FormState>();
  String mobile='';
  String amount='0.0';
  String note;
  LocalData localData;
  BalanceController getBalance;
  String searchedName='';
  bool accountExists = false;
  bool agreeTandC= false;
  bool isApiCallProgress = false;
  bool disableMobileNumber = false;
  Future _getUserDetails;
  Future<CheckFeeResponseModel> _checkFee;
  CheckFeeRequestModel checkFeeRequestModel;
  double balance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localData= Provider.of<LocalData>(context,listen: false);
    getBalance = Provider.of<BalanceController>(context,listen:false);
    balance = getBalance.balance;
    checkFeeRequestModel = new CheckFeeRequestModel();
  }
  @override
  Widget build(BuildContext context) {
    var translate = DemoLocalization.of(context);
    return isApiCallProgress?Container(
      height: MediaQuery.of(context).size.height*0.6,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ):Container(
      height: MediaQuery.of(context).size.height*0.77,
      child: FutureBuilder<CheckFeeResponseModel>(
        future: _checkFee,
        builder: (context, snapshot) {
          double fees= 0.0;
          if(snapshot.hasData){
            fees =snapshot.data.fee;
          }
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    maxLength: 10,
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
                        if(mobile.length==10){
                          _getUserDetails = GetUserDetailsApi().getUserDetails(localData.token, mobile);
                        }
                      });
                    },
                    readOnly: disableMobileNumber,
                    decoration: inputDecoration.copyWith(
                      labelText: translate.getTranslatedValue('Mobile Number'),
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  mobile.length==10?Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: FutureBuilder<GetUserDetailsResponseModel>(
                      future: _getUserDetails,
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          if(mobile==localData.data.mobile){
                            return Text(
                              'Cannot transfer money to your own wallet.',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.red
                              ),
                            );
                          }else{
                            if(snapshot.data.status==1){
                              List<Map> user = [];
                              user.add({'name':snapshot.data.user.name,'id' : snapshot.data.user.walletId});
                              return DropdownButtonFormField(
                                validator: (val) => val==null
                                    ? translate.getTranslatedValue('Receiver name can not be empty')
                                    : null,
                                isExpanded: true,
                                decoration: inputDecoration.copyWith(
                                    labelText:translate.getTranslatedValue('Select Receiver Name')
                                ),
                                items:user.map((user){
                                  return DropdownMenuItem(
                                    value: user['name'],
                                    child: Text(
                                      user['name']+' '+user['id'],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val){
                                  disableMobileNumber = true;
                                  accountExists = true;
                                },
                              );
                            }else{
                              return Text(
                                'Wallet with this mobile number does not exists',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.red
                                ),
                              );
                            }
                          }
                        }else{
                          return Center(child: CircularProgressIndicator());
                        }
                      }
                    ),
                  ):Offstage(),
                  TextFormField(
                    keyboardType:TextInputType.numberWithOptions(
                      decimal: true,
                    ) ,
                    validator: (val) =>
                    val.isEmpty
                        ? translate.getTranslatedValue('Amount is required')
                        : null,
                    onChanged: (val) {
                      checkFeeRequestModel.amount = int.parse(val);
                      checkFeeRequestModel.transType = 'Wallet to Wallet';
                      setState(() {
                        amount = val;
                        if(val.length==0){
                          balance = getBalance.balance;
                        }else{
                          balance = getBalance.balance - double.parse(val);
                        }
                        _checkFee = CheckFeeApi().checkFee(checkFeeRequestModel, localData.token);
                      });
                    },
                    decoration:inputDecoration.copyWith(labelText: translate.getTranslatedValue("Amount")),

                  ),
                  SizedBox(height: 10.0,),
                  Text(
                    'Wallet Balance: XOF $balance',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 17.0
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Text(
                    'XOF $fees will be charged as fee and XOF 0 will be sent to the receiver',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 17.0
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  TextFormField(
                    keyboardType: TextInputType.multiline,

                    onChanged: (val) {
                      setState(() {
                        note = val;
                      });
                    },
                    decoration:inputDecoration.copyWith(
                        labelText: translate.getTranslatedValue("Note"),
                        alignLabelWithHint: true
                    ),
                  ),
                  SizedBox(height: 10.0,),
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
                  Spacer(),
                  GreenButton(
                      text: amount=='0.0'?"Proceed":"Collect ${double.parse(amount)+fees} Proceed",
                      onClicked: () async {
                        if(_formKey.currentState.validate()){
                          if(agreeTandC){
                            if(accountExists){
                                SendMoneyToWalletRequestModel requestModel = new SendMoneyToWalletRequestModel();
                                requestModel.note = note;
                                requestModel.receiverMobile = mobile;
                                requestModel.sendingAmount = int.parse(amount);
                                  setState(() {
                                    isApiCallProgress = true;
                                  });
                                SendMoneyToWalletResponseModel responseModel =await SendMoneyToWalletApi().sendMoneyToWallet(localData.token, requestModel);
                                setState(() {
                                  isApiCallProgress = false;
                                  disableMobileNumber = false;
                                  amount="0.0";
                                });
                                if(responseModel!=null){
                                  Fluttertoast.showToast(msg: responseModel.message);
                                  if(responseModel.status==1){
                                    Get.offAll(()=>SuccessScreen(message: responseModel.message,balance: responseModel.balance,));
                                  }
                                }else{
                                  Fluttertoast.showToast(msg: 'Something went wrong');
                                }

                            }
                            else{
                              Fluttertoast.showToast(msg: 'This Wallet account does no not exists, please check phone number again');
                            }
                          }else{
                            Fluttertoast.showToast(msg: 'Agree to the Terms and Condition');
                          }
                        }
                      }
                  ),
                  SizedBox(height: 20.0,),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
  // _searchUserName(String mobile) async {
  //   GetUserDetailsRequestModel requestModel = new GetUserDetailsRequestModel();
  //   requestModel.mobile = mobile;
  //   GetUserDetailsResponseModel responseModel =await GetUserDetailsApi().getUserDetails(localData.token, requestModel);
  //   if(responseModel!=null){
  //     if(responseModel.status==1){
  //       setState(() {
  //         searchedName =responseModel.user.name;
  //         accountExists = true;
  //       });
  //     }else{
  //       setState(() {
  //         searchedName = 'Wallet for this number does not exist!';
  //         accountExists = false;
  //       });
  //     }
  //   }else{
  //     setState(() {
  //       searchedName = '';
  //       accountExists = false;
  //     });
  //   }
  // }
}

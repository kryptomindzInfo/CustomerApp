import 'package:beyond_wallet/api_services/check_fee_api.dart';
import 'package:beyond_wallet/api_services/send_money_to_non_wallet_api.dart';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/localization/localization.dart';
import 'package:beyond_wallet/models/check_fee_model.dart';
import 'package:beyond_wallet/models/send_money_to_non_wallet_model.dart';
import 'package:beyond_wallet/services/shared_prefs.dart';
import 'package:beyond_wallet/widgets/button.dart';
import 'package:beyond_wallet/widgets/sucess_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
class SendMoneyToNonWallet extends StatefulWidget {
  final Map contact;

  const SendMoneyToNonWallet({Key key, this.contact}) : super(key: key);
  @override
  _SendMoneyToNonWalletState createState() => _SendMoneyToNonWalletState();
}

class _SendMoneyToNonWalletState extends State<SendMoneyToNonWallet> {
  final _formKey = GlobalKey<FormState>();
  String mobile;
  List user = [];
  DateTime _date = DateTime.now();
  List<String> types = ['National ID' , 'Passport'];
  String note;
  SendMoneyToNonWalletRequestModel sendMoneyData;
  String validTillDate;
  Future<CheckFeeResponseModel> _checkFee;
  List countryList = ["Afghanistan","Albania","Algeria","Andorra","Angola","Anguilla","Antigua &amp; Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia &amp; Herzegovina","Botswana","Brazil","British Virgin Islands","Brunei","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Cape Verde","Cayman Islands","Chad","Chile","China","Colombia","Congo","Cook Islands","Costa Rica","Cote D Ivoire","Croatia","Cruise Ship","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Estonia","Ethiopia","Falkland Islands","Faroe Islands","Fiji","Finland","France","French Polynesia","French West Indies","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guam","Guatemala","Guernsey","Guinea","Guinea Bissau","Guyana","Haiti","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Isle of Man","Israel","Italy","Jamaica","Japan","Jersey","Jordan","Kazakhstan","Kenya","Kuwait","Kyrgyz Republic","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macau","Macedonia","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Mauritania","Mauritius","Mexico","Moldova","Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Namibia","Nepal","Netherlands","Netherlands Antilles","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Palestine","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Qatar","Reunion","Romania","Russia","Rwanda","Saint Pierre &amp; Miquelon","Samoa","San Marino","Satellite","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","South Africa","South Korea","Spain","Sri Lanka","St Kitts &amp; Nevis","St Lucia","St Vincent","St. Lucia","Sudan","Suriname","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","Timor L'Este","Togo","Tonga","Trinidad &amp; Tobago","Tunisia","Turkey","Turkmenistan","Turks &amp; Caicos","Uganda","Ukraine","United Arab Emirates","United Kingdom","Uruguay","Uzbekistan","Venezuela","Vietnam","Virgin Islands (US)","Yemen","Zambia","Zimbabwe"];
  bool isApiCallProgress = false;
  CheckFeeRequestModel checkFeeRequestModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sendMoneyData = SendMoneyToNonWalletRequestModel();
    checkFeeRequestModel = new CheckFeeRequestModel();
    sendMoneyData.receiverIdentificationCountry = 'Senegal';
    sendMoneyData.receiverCountry = 'Senegal';
    if(widget.contact!=null){
      sendMoneyData.receiverMobile = widget.contact['mobile'];
      sendMoneyData.receiverGivenName = widget.contact['name'];
      sendMoneyData.receiverFamilyName = widget.contact['lastName'];
      sendMoneyData.receiverEmail = widget.contact['email'];
      sendMoneyData.receiverCountry = widget.contact['country'];
    }
  }
  @override
  Widget build(BuildContext context) {
    LocalData localData = Provider.of<LocalData>(context);
    var translate = DemoLocalization.of(context);
    var width = MediaQuery.of(context).size.width;
    return isApiCallProgress?Container(
      height: MediaQuery.of(context).size.height*0.6,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ):Form(
      key: _formKey,
      child: FutureBuilder<CheckFeeResponseModel>(
        future: _checkFee,
        builder: (context, snapshot) {
          double fees= 0.0;
          if(snapshot.hasData){
            fees =snapshot.data.fee;
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal:10.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0,),
                  TextFormField(
                    initialValue: sendMoneyData.receiverMobile,
                    maxLength: 10,
                    keyboardType:TextInputType.numberWithOptions(
                      decimal: true,
                    ) ,
                    validator: (val) =>
                    val.isEmpty || val.length<10
                        ? translate.getTranslatedValue('Invalid Mobile Number')
                        : null,
                    onChanged: (val) {
                      sendMoneyData.receiverMobile= val;
                    },
                    decoration: inputDecoration.copyWith(
                      labelText: translate.getTranslatedValue('Mobile Number'),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: width*0.47,
                        child: TextFormField(
                          initialValue: sendMoneyData.receiverGivenName,
                          validator: (val) =>
                          val.isEmpty
                              ? translate.getTranslatedValue('Name is Required')
                              : null,
                          onChanged: (val) {
                            sendMoneyData.receiverGivenName = val;
                          },
                          decoration: inputDecoration.copyWith(
                            labelText: translate.getTranslatedValue('Given Name'),
                          ),
                        ),
                      ),
                      Container(
                        width: width*0.47,
                        child: TextFormField(
                          initialValue: sendMoneyData.receiverFamilyName,
                          validator: (val) =>
                          val.isEmpty
                              ? translate.getTranslatedValue('Family Name is required')
                              : null,
                          onChanged: (val) {
                            sendMoneyData.receiverFamilyName = val;
                          },
                          decoration: inputDecoration.copyWith(
                            labelText: translate.getTranslatedValue('Family Name'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    validator: (val) =>
                    val.isEmpty
                        ? translate.getTranslatedValue("Address is Required")
                        : null,
                    onChanged: (val) {
                      sendMoneyData.receiverAddress = val;
                    },
                    decoration: inputDecoration.copyWith(
                      labelText: translate.getTranslatedValue('Address'),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: width*0.47,
                        child: TextFormField(
                          validator: (val) =>
                          val.isEmpty
                              ? translate.getTranslatedValue('State is Required')
                              : null,
                          onChanged: (val) {
                            sendMoneyData.receiverState = val;
                          },
                          decoration: inputDecoration.copyWith(
                            labelText: translate.getTranslatedValue('State'),
                          ),
                        ),
                      ),
                      Container(
                        width: width*0.47,
                        child: TextFormField(
                          keyboardType:TextInputType.numberWithOptions(
                            decimal: true,
                          ) ,
                          validator: (val) =>
                          val.isEmpty
                              ? translate.getTranslatedValue('Zip Code Required')
                              : null,
                          onChanged: (val) {
                            sendMoneyData.receiverZip = val;
                          },
                          decoration: inputDecoration.copyWith(
                            labelText: translate.getTranslatedValue('Zip Code'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: width*0.47,
                        child: DropdownButtonFormField(
                          validator: (val) =>
                          val==null
                              ? translate.getTranslatedValue('Country is Required')
                              : null,
                          isExpanded: true,
                          decoration: inputDecoration.copyWith(
                              labelText:translate.getTranslatedValue('Country'),
                          ),
                          value: sendMoneyData.receiverCountry??"Senegal",
                          items:countryList.map((country){
                            return DropdownMenuItem(
                              value: country,
                              child: Text(
                                country,
                              ),
                            );
                          }).toList(),
                          onChanged: (val){
                            sendMoneyData.receiverCountry=val;
                          },
                        ),
                      ),
                      Container(
                        width: width*0.47,
                        child: TextFormField(
                          initialValue: sendMoneyData.receiverEmail,
                          validator: (input) => input.isValidEmail() ? null : translate.getTranslatedValue('Enter Valid Email'),
                          onChanged: (val) {
                            sendMoneyData.receiverEmail = val;
                          },
                          decoration: inputDecoration.copyWith(
                            labelText: translate.getTranslatedValue('Email'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: sendMoneyData.withoutId??false,
                            onChanged: (val){
                              setState(() {
                                sendMoneyData.withoutId =  val;
                              });
                            },
                          ),
                          Text(
                              'Require ID'
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: sendMoneyData.requireOtp??false,
                            onChanged: (val){
                              setState(() {
                                sendMoneyData.requireOtp =  val;
                              });
                            },
                          ),
                          Text(
                              'Require OTP authentication'
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Text(
                    'Receiver Identification',
                    style: TextStyle(
                      fontSize: 25.0,

                    ),

                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 70,
                        width: width*0.47,
                        child: DropdownButtonFormField(
                          validator: (val) =>
                          val==null
                              ? translate.getTranslatedValue('Country is Required')
                              : null,
                          isExpanded: true,
                          decoration: inputDecoration.copyWith(
                              labelText:translate.getTranslatedValue('Country')
                          ),
                          value: 'Senegal',
                          items:countryList.map((country){
                            return DropdownMenuItem(
                              value: country,
                              child: Text(
                                country,
                              ),
                            );
                          }).toList(),
                          onChanged: (val){
                            sendMoneyData.receiverIdentificationCountry = val;
                          },
                        ),
                      ),
                      Container(
                        height: 70,
                        width: width*0.47,
                        child: DropdownButtonFormField(
                          validator: (val) =>
                          val==null
                              ? translate.getTranslatedValue('Doc Type is Required')
                              : null,
                          isExpanded: true,
                          decoration: inputDecoration.copyWith(
                              labelText:translate.getTranslatedValue('Select Type')
                          ),
                          items:types.map((type){
                            return DropdownMenuItem(
                              value: type,
                              child: Text(
                                type,
                              ),
                            );
                          }).toList(),
                          onChanged: (val){
                            sendMoneyData.receiverIdentificationType = val;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Container(
                        width: width*0.47,
                        child: TextFormField(
                          maxLength: 10,
                          keyboardType:TextInputType.numberWithOptions(
                            decimal: true,
                          ) ,
                          validator: (val) =>
                          val.isEmpty
                              ? translate.getTranslatedValue('Invalid ID Number')
                              : null,
                          onChanged: (val) {
                            sendMoneyData.receiverIdentificationNumber = int.parse(val);
                          },
                          decoration: inputDecoration.copyWith(
                            labelText: translate.getTranslatedValue('Identification Number'),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          _selectDate(context);
                        },
                        child: Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: primaryColor,width: 1.5)
                          ),
                          width: width*0.47,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              validTillDate==null?
                              Text(
                                'Valid Till',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey
                                ),
                              ):
                              Text(
                                  validTillDate.substring(0,10),
                                style: TextStyle(
                                  fontSize: 15.0
                                ),
                              ),
                              Icon(
                                Icons.date_range_outlined,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    maxLength: 10,
                    keyboardType:TextInputType.numberWithOptions(
                      decimal: true,
                    ) ,
                    validator: (val) =>
                    val.isEmpty
                        ? translate.getTranslatedValue('Amount is required')
                        : null,
                    onChanged: (val) {
                      checkFeeRequestModel.amount = int.parse(val);
                      checkFeeRequestModel.transType = 'Wallet to Non Wallet';
                      setState(() {
                        _checkFee = CheckFeeApi().checkFee(checkFeeRequestModel, localData.token);
                        sendMoneyData.receiverIdentificationAmount = int.parse(val);
                      });
                    },
                    decoration: inputDecoration.copyWith(
                      labelText: translate.getTranslatedValue('Amount'),
                    ),
                  ),
                  Text(
                    'XOF $fees will be charged as fee and XOF ${sendMoneyData.receiverIdentificationAmount??0} will be sent to the receiver',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 17.0
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    onChanged: (val) {
                      sendMoneyData.note = val;
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
                        value: sendMoneyData.isInclusive??false,
                        onChanged: (val){
                          setState(() {
                            sendMoneyData.isInclusive =  val;
                          });
                        },
                      ),
                      Text(
                          'Sender pays transaction fees'
                      )
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: sendMoneyData.interbank??true,
                        onChanged: (val){
                          setState(() {
                            sendMoneyData.interbank =  val;
                          });
                        },
                      ),
                      Text(
                          'Receiver can recieve from any bank'
                      )
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: sendMoneyData.acceptedTerms??false,
                        onChanged: (val){
                          setState(() {
                            sendMoneyData.acceptedTerms =  val;
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
                  SizedBox(height: 10.0,),
                  GreenButton(
                    text: sendMoneyData.receiverIdentificationAmount==null?"Proceed":"Proceed XOF${sendMoneyData.receiverIdentificationAmount+fees}",
                    onClicked: ()async{
                        if(_formKey.currentState.validate()){
                          sendMoneyData.acceptedTerms = sendMoneyData.acceptedTerms??false;
                          if(sendMoneyData.acceptedTerms){
                            sendMoneyData.withoutId=sendMoneyData.withoutId??false;
                            sendMoneyData.withoutId=!sendMoneyData.withoutId;
                            sendMoneyData.requireOtp=sendMoneyData.requireOtp??false;
                            sendMoneyData.isInclusive=sendMoneyData.isInclusive??false;
                            sendMoneyData.interbank=sendMoneyData.interbank??true;
                            sendMoneyData.receiverIdentificationValidTill = validTillDate;
                            setState(() {
                              isApiCallProgress = true;
                            });
                            SendMoneyToNonWalletResponseModel responseModel =await SendMoneyToNonWalletApi().sendMoneyToNonWallet(localData.token, sendMoneyData);
                            setState(() {
                              isApiCallProgress = false;
                            });
                            if(responseModel!=null){
                              Fluttertoast.showToast(msg: responseModel.message);
                              if(responseModel.status==1){
                                Get.offAll(()=>SuccessScreen(message: responseModel.message,transactionId: responseModel.transactionId,));
                              }
                            }else{
                              Fluttertoast.showToast(msg: 'Something went wrong');
                            }
                          }else{
                            Fluttertoast.showToast(msg: 'Accept Terms and Conditions');
                          }
                        }
                      },
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
  Future<Null> _selectDate(BuildContext context)async{
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: _date,
      lastDate:DateTime(2100) ,
    );
    if(picked !=null && picked!=_date){
      setState(() {
        validTillDate=picked.toString();
      });
    }
  }
}

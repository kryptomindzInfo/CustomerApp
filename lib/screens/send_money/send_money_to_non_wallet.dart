import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/localization/localization.dart';
import 'package:beyond_wallet/models/send_money_to_non_wallet_model.dart';
import 'package:beyond_wallet/widgets/button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SendMoneyToNonWallet extends StatefulWidget {
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
  bool agreeTandC= false;
  bool requireID= false;
  bool requireOTP = false;
  bool senderPaysTrFees= false;
  bool receiveFromAnyBank = true;
  List countryList = ["Afghanistan","Albania","Algeria","Andorra","Angola","Anguilla","Antigua &amp; Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia &amp; Herzegovina","Botswana","Brazil","British Virgin Islands","Brunei","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Cape Verde","Cayman Islands","Chad","Chile","China","Colombia","Congo","Cook Islands","Costa Rica","Cote D Ivoire","Croatia","Cruise Ship","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Estonia","Ethiopia","Falkland Islands","Faroe Islands","Fiji","Finland","France","French Polynesia","French West Indies","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guam","Guatemala","Guernsey","Guinea","Guinea Bissau","Guyana","Haiti","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Isle of Man","Israel","Italy","Jamaica","Japan","Jersey","Jordan","Kazakhstan","Kenya","Kuwait","Kyrgyz Republic","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macau","Macedonia","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Mauritania","Mauritius","Mexico","Moldova","Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Namibia","Nepal","Netherlands","Netherlands Antilles","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Palestine","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Qatar","Reunion","Romania","Russia","Rwanda","Saint Pierre &amp; Miquelon","Samoa","San Marino","Satellite","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","South Africa","South Korea","Spain","Sri Lanka","St Kitts &amp; Nevis","St Lucia","St Vincent","St. Lucia","Sudan","Suriname","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","Timor L'Este","Togo","Tonga","Trinidad &amp; Tobago","Tunisia","Turkey","Turkmenistan","Turks &amp; Caicos","Uganda","Ukraine","United Arab Emirates","United Kingdom","Uruguay","Uzbekistan","Venezuela","Vietnam","Virgin Islands (US)","Yemen","Zambia","Zimbabwe"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    sendMoneyData = Provider.of<SendMoneyToNonWalletRequestModel>(context);
    var translate = DemoLocalization.of(context);
    var width = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
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
                  sendMoneyData.receiverMobile= val;
                });
              },
              decoration: inputDecoration.copyWith(
                labelText: translate.getTranslatedValue('Mobile Number'),
              ),
            ),
            SizedBox(height: 5.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: width*0.47,
                  child: TextFormField(
                    maxLength: 10,
                    keyboardType:TextInputType.numberWithOptions(
                      decimal: true,
                    ) ,
                    validator: (val) =>
                    val.isEmpty || val.length<10
                        ? translate.getTranslatedValue('Given Name is required')
                        : null,
                    onChanged: (val) {
                      setState(() {
                        sendMoneyData.receiverGivenName = val;
                      });
                    },
                    decoration: inputDecoration.copyWith(
                      labelText: translate.getTranslatedValue('Given Name'),
                    ),
                  ),
                ),
                Container(
                  width: width*0.47,
                  child: TextFormField(
                    maxLength: 10,
                    keyboardType:TextInputType.numberWithOptions(
                      decimal: true,
                    ) ,
                    validator: (val) =>
                    val.isEmpty || val.length<10
                        ? translate.getTranslatedValue('Family Name is required')
                        : null,
                    onChanged: (val) {
                      setState(() {
                        sendMoneyData.receiverFamilyName = val;
                      });
                    },
                    decoration: inputDecoration.copyWith(
                      labelText: translate.getTranslatedValue('Family Name'),
                    ),
                  ),
                ),
              ],
            ),
            TextFormField(
              maxLength: 10,
              keyboardType:TextInputType.numberWithOptions(
                decimal: true,
              ) ,
              // validator: (val) =>
              // val.isEmpty || val.length<10
              //     ? translate.getTranslatedValue('Invalid Mobile Number')
              //     : null,
              onChanged: (val) {

              },
              decoration: inputDecoration.copyWith(
                labelText: translate.getTranslatedValue('Address'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: width*0.47,
                  child: TextFormField(
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
                      });
                    },
                    decoration: inputDecoration.copyWith(
                      labelText: translate.getTranslatedValue('State'),
                    ),
                  ),
                ),
                Container(
                  width: width*0.47,
                  child: TextFormField(
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
                      });
                    },
                    decoration: inputDecoration.copyWith(
                      labelText: translate.getTranslatedValue('Zip Code'),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 70,
                  width: width*0.45,
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    decoration: inputDecoration.copyWith(
                        labelText:translate.getTranslatedValue('Country')
                    ),
                    items:countryList.map((country){
                      return DropdownMenuItem(
                        value: country,
                        child: Text(
                          country,
                        ),
                      );
                    }).toList(),
                    onChanged: (val){
                    },
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
                        ? translate.getTranslatedValue('Email is required')
                        : null,
                    onChanged: (val) {
                      setState(() {
                        sendMoneyData.receiverEmail = val;
                      });
                    },
                    decoration: inputDecoration.copyWith(
                      labelText: translate.getTranslatedValue('Email'),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: requireID,
                  onChanged: (val){
                    setState(() {
                      requireID =  val;
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
                  value: requireOTP,
                  onChanged: (val){
                    setState(() {
                      requireOTP =  val;
                    });
                  },
                ),
                Text(
                  'Require OTP authentication'
                )
              ],
            ),
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
                  width: width*0.45,
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    decoration: inputDecoration.copyWith(
                        labelText:translate.getTranslatedValue('Country')
                    ),
                    items:countryList.map((country){
                      return DropdownMenuItem(
                        value: country,
                        child: Text(
                          country,
                        ),
                      );
                    }).toList(),
                    onChanged: (val){
                      sendMoneyData.receiverCountry = val;
                    },
                  ),
                ),
                Container(
                  //height: 70,
                  width: width*0.45,
                  child: DropdownButtonFormField(
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: width*0.47,
                  child: TextFormField(
                    maxLength: 10,
                    keyboardType:TextInputType.numberWithOptions(
                      decimal: true,
                    ) ,
                    validator: (val) =>
                    val.isEmpty || val.length<10
                        ? translate.getTranslatedValue('Invalid ID Number')
                        : null,
                    onChanged: (val) {
                      setState(() {
                        sendMoneyData.receiverIdentificationNumber = val;
                      });
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
                    height: 60.0,
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
            TextFormField(
              maxLength: 10,
              keyboardType:TextInputType.numberWithOptions(
                decimal: true,
              ) ,
              validator: (val) =>
              val.isEmpty || val.length<10
                  ? translate.getTranslatedValue('Amount is required')
                  : null,
              onChanged: (val) {
                setState(() {
                  sendMoneyData.sendingAmount = int.parse(val);
                });
              },
              decoration: inputDecoration.copyWith(
                labelText: translate.getTranslatedValue('Amount'),
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 5,//Normal textInputField will be displayed
              maxLines: 5,// when user presses enter it will adapt to it
              onChanged: (val) {
                setState(() {
                  sendMoneyData.note = val;
                });
              },
              decoration:inputDecoration.copyWith(
                  labelText: translate.getTranslatedValue("Note"),
                  alignLabelWithHint: true
              ),
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: senderPaysTrFees,
                  onChanged: (val){
                    setState(() {
                      senderPaysTrFees =  val;
                    });
                  },
                ),
                Text(
                    'Sender pays transaction fees'
                )
              ],
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: receiveFromAnyBank,
                  onChanged: (val){
                    setState(() {
                      receiveFromAnyBank =  val;
                    });
                  },
                ),
                Text(
                    'Receiver can recieve from any bank'
                )
              ],
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
              text: 'Proceed',
              onClicked: (){
                sendMoneyData.receiverIdentificationValidTill = validTillDate;
                sendMoneyData.requireOtp = requireOTP?'1' : '0';
                sendMoneyData.withoutId= requireID? '0' : '1';
                print(sendMoneyData.toJson());
              },
            )
          ],
        ),
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

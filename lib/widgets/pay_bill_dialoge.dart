import 'package:beyond_wallet/api_services/get_invoice_by_mobile_api.dart';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/get_invoice_by_mobile_model.dart';
import 'package:beyond_wallet/screens/pay_bills/show_invoice_by_bills.dart';
import 'package:beyond_wallet/screens/pay_bills/show_invoices.dart';
import 'package:beyond_wallet/screens/pay_bills/show_invoices_by_cc.dart';
import 'package:beyond_wallet/services/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
class PayBillDialoge extends StatefulWidget {
  String merchantID;

  PayBillDialoge({this.merchantID});

  @override
  _PayBillDialogeState createState() => _PayBillDialogeState();
}

class _PayBillDialogeState extends State<PayBillDialoge> {
  List searchBy = ['Mobile Number','Bill Number','Customer Code'];
  String type='Mobile Number';
  String number;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(10.0),
          height: 300.0,
          child: Center(
            child:Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Pay Bills',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 20.0,),
                DropdownButtonFormField(
                  validator: (val) =>
                  val==null
                      ? 'Type is Required'
                      : null,
                  isExpanded: true,
                  decoration: inputDecoration.copyWith(
                      labelText:'Type'
                  ),
                  value: 'Mobile Number',
                  items:searchBy.map((doc){
                    return DropdownMenuItem(
                      value: doc,
                      child: Text(
                        doc,
                      ),
                    );
                  }).toList(),
                  onChanged: (val){
                    setState(() {
                      type = val;
                    });
                  },
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  validator: (val) =>
                  val.isEmpty
                      ? 'Required'
                      : null,
                  onChanged: (val) {
                   setState(() {
                     number = val;
                   });
                  },
                  decoration: inputDecoration.copyWith(
                    labelText: 'Mobile/Invoice ID/Customer Code',
                  ),
                ),
                Spacer(),
                RaisedButton(
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      Navigator.pop(context);
                      if(type=='Mobile Number'){
                        Get.to(()=>ShowInvoices(
                          merchantId: widget.merchantID,
                          number: number,
                          type: type,
                        ));
                      }else if(type == 'Customer Code'){
                        Get.to(()=>ShowInvoicesByCc(
                          merchantId: widget.merchantID,
                          number: number,
                          type: type,
                        ));
                      }else{
                        Get.to(()=>ShowInvoiceByBills(
                          merchantId: widget.merchantID,
                          number: number,
                          type: type,
                        ));
                      }
                    }

                  },
                  child: Text(
                    'Get',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  color: primaryColor,
                ),
                SizedBox(height: 10.0,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:beyond_wallet/api_services/check_bill_fee_api.dart';
import 'package:beyond_wallet/api_services/get_invoice_by_cc_api.dart';
import 'package:beyond_wallet/api_services/get_invoice_by_mobile_api.dart';
import 'package:beyond_wallet/api_services/get_merchant_penalty_rule_api.dart';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/check_bill_fee_model.dart';
import 'package:beyond_wallet/models/get_invoice_by_cc_model.dart';
import 'package:beyond_wallet/models/get_invoice_by_mobile_model.dart';
import 'package:beyond_wallet/models/get_merchant_penalty_rule_model.dart';
import 'package:beyond_wallet/services/shared_prefs.dart';
import 'package:beyond_wallet/widgets/Loader.dart';
import 'package:beyond_wallet/widgets/appBar.dart';
import 'package:beyond_wallet/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:beyond_wallet/screens/pay_bills/detailed_invoice.dart';

class ShowInvoicesByCc extends StatefulWidget {
  final  String merchantId;
  final  String type;
  final String number;

  ShowInvoicesByCc({this.merchantId, this.type, this.number});

  @override
  _ShowInvoicesByCcState createState() => _ShowInvoicesByCcState();
}

class _ShowInvoicesByCcState extends State<ShowInvoicesByCc> {

  Future _getInvoices;
  List<Invoice> invoices=[];
  GetInvoiceByCcRequestModel ccRequestModel;
  Future<CheckBillFeeResponseModel> _checkBillFee;
  Future<GetMerchantPenaltyRuleResponseModel> _getPenalty;
  LocalData localData;
  int sum = 0;
  List<double> fees =[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localData = Provider.of<LocalData>(context,listen: false);
    ccRequestModel= new GetInvoiceByCcRequestModel();
    ccRequestModel.merchantId= widget.merchantId;
    ccRequestModel.customerCode= widget.number;
    GetMerchantPenaltyRuleRequestModel penaltyRuleRequestModel = new GetMerchantPenaltyRuleRequestModel();
    penaltyRuleRequestModel.merchantId = widget.merchantId;
    _getPenalty = GetMerchantPenaltyRuleApi().getMerchantPenaltyRule(penaltyRuleRequestModel, localData.token);
  }
  bool filter = true;
  @override
  Widget build(BuildContext context) {
    _getInvoices = GetInvoiceByCCApi().getInvoiceByCC(ccRequestModel, localData.token);
    localData = Provider.of<LocalData>(context,listen: false);
    return Scaffold(
        appBar: appBar('Invoices By Customer Code', context,true),
        body:FutureBuilder<GetMerchantPenaltyRuleResponseModel>(
          future: _getPenalty,
          builder: (context, getPenaltySnapshot) {
            if(getPenaltySnapshot.hasData){
              return FutureBuilder<GetInvoiceByCcResponseModel>(
                  future: _getInvoices,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      if(filter){
                        for(Invoice invoice in snapshot.data.invoice){
                          if(invoice.paid==0){
                            invoices.add(invoice);
                            CheckBillFeeRequestModel requestModel = new CheckBillFeeRequestModel();
                            requestModel.amount = invoice.amount+getPenaltySnapshot.data.rule.fixedAmount;
                            requestModel.merchantId =invoice.merchantId;
                            CheckBillFeeApi().checkBillFee(requestModel, localData.token).then((value) => fees.add(value.fee));
                          }
                        }
                        filter = false;
                      }
                      return
                        invoices.isEmpty?
                        Center(
                          child: Text('No Invoices Found'),
                        ):
                        Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: invoices.length,
                                itemBuilder: (context,index){
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Card(
                                      child: InkWell(
                                        onTap: (){
                                          Get.to(()=>InvoiceDetails(
                                            invoices: invoices[index],
                                          ));
                                        },
                                        child: Container(
                                          height: 120,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                              text:'Amount: ',
                                                              style: TextStyle(
                                                                  fontSize: 16.0,
                                                                  color: Colors.black54
                                                              )
                                                          ),
                                                          TextSpan(
                                                            text: invoices[index].amount.toString(),
                                                            style: TextStyle(
                                                                color: primaryColor,
                                                                fontSize: 20.0,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ]
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0,),
                                                  RichText(
                                                    text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                              text:'Fees: ',
                                                              style: TextStyle(
                                                                  fontSize: 16.0,
                                                                  color: Colors.black54
                                                              )
                                                          ),
                                                          TextSpan(
                                                            text: fees==null?"0.0":fees[index].toString(),
                                                            style: TextStyle(
                                                              color: primaryColor,
                                                              fontSize: 17.0,
                                                            ),
                                                          ),
                                                        ]
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0,),
                                                  Text(
                                                    "Bill no. ${invoices[index].number}",
                                                    style: TextStyle(
                                                        fontSize: 15.0
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0,),
                                                  Text(
                                                    'Due Date: ${invoices[index].dueDate}',
                                                    style: TextStyle(
                                                        fontSize: 17.0
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Checkbox(value: invoices[index].paid==0?false:true, onChanged: (val){
                                                setState(() {
                                                  invoices[index].paid = val?1:0;
                                                  if(val){
                                                    sum =sum + invoices[index].amount;
                                                  }else{
                                                    sum =sum - invoices[index].amount;
                                                  }
                                                });
                                              }
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GreenButton(
                                text: 'Pay XOF $sum',
                                onClicked: (){

                                },
                              ),
                            )
                          ],
                        );
                    }else{
                      return Loader();
                    }
                  }
              );
            }else{
              return Loader();
            }
          }
        )
    );
  }
}

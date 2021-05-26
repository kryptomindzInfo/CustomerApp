import 'package:beyond_wallet/api_services/check_bill_fee_api.dart';
import 'package:beyond_wallet/api_services/get_invoice_by_cc_api.dart';
import 'package:beyond_wallet/api_services/get_invoice_by_mobile_api.dart';
import 'package:beyond_wallet/api_services/get_merchant_penalty_rule_api.dart';
import 'package:beyond_wallet/api_services/pay_invoice_api.dart';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/check_bill_fee_model.dart';
import 'package:beyond_wallet/models/get_invoice_by_cc_model.dart';
import 'package:beyond_wallet/models/get_invoice_by_mobile_model.dart';
import 'package:beyond_wallet/models/get_merchant_penalty_rule_model.dart';
import 'package:beyond_wallet/models/pay_invoice_model.dart';
import 'package:beyond_wallet/services/shared_prefs.dart';
import 'package:beyond_wallet/widgets/Loader.dart';
import 'package:beyond_wallet/widgets/appBar.dart';
import 'package:beyond_wallet/widgets/button.dart';
import 'package:beyond_wallet/widgets/sucess_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:beyond_wallet/screens/pay_bills/detailed_invoice.dart';

import 'detailed_cc_invoice.dart';

class ShowInvoicesByCc extends StatefulWidget {
  final  String merchantId;
  final  String type;
  final String number;

  ShowInvoicesByCc({this.merchantId, this.type, this.number});

  @override
  _ShowInvoicesByCcState createState() => _ShowInvoicesByCcState();
}

class _ShowInvoicesByCcState extends State<ShowInvoicesByCc> with AutomaticKeepAliveClientMixin{

  Future _getInvoices;
  List<CcInvoice> invoices=[];
  GetInvoiceByCcRequestModel ccRequestModel;
  Future<CheckBillFeeResponseModel> _checkBillFee;
  Future<GetMerchantPenaltyRuleResponseModel> _getPenalty;
  LocalData localData;
  double sum = 0;
  List<double> fees =[];
  PayInvoiceRequestModel payInvoiceRequest = new PayInvoiceRequestModel();
  List<Invoice> payInvoices =[];
  bool isApiCallProgress = false;

  @override
  bool get wantKeepAlive => true;
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
    return isApiCallProgress?Loader():Scaffold(
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
                        for(CcInvoice invoice in snapshot.data.invoice){
                          if(invoice.paid==0){
                            invoices.add(invoice);
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
                                  CheckBillFeeRequestModel requestModel = new CheckBillFeeRequestModel();
                                  requestModel.amount = invoices[index].amount+getPenaltySnapshot.data.rule.fixedAmount;
                                  requestModel.merchantId =invoices[index].merchantId;
                                  return FutureBuilder<CheckBillFeeResponseModel>(
                                    future: CheckBillFeeApi().checkBillFee(requestModel, localData.token),
                                    builder: (context, feeSnapshot) {
                                      return Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Card(
                                          child: InkWell(
                                            onTap: (){
                                              Get.to(()=>CCInvoiceDetails(
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
                                                                text: feeSnapshot.hasData?feeSnapshot.data.fee.toString():"NA",
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
                                                      if(feeSnapshot.hasData){
                                                        invoices[index].paid = val?1:0;
                                                        if(val){
                                                          sum = sum + invoices[index].amount + feeSnapshot.data.fee;
                                                          Invoice invoice= new Invoice();
                                                          payInvoiceRequest.merchantId = invoices[index].merchantId;
                                                          invoice.id = invoices[index].id;
                                                          invoice.penalty = getPenaltySnapshot.data.rule.fixedAmount;
                                                          payInvoices.add(invoice);
                                                        }else{
                                                          sum =sum - invoices[index].amount - feeSnapshot.data.fee;
                                                        }
                                                      }
                                                    }
                                                    );
                                                  }
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GreenButton(
                                text: 'Pay XOF ${sum.toString()}',
                                onClicked: () async {
                                  if(payInvoices.isNotEmpty){
                                    payInvoiceRequest.invoices = payInvoices;
                                    print(payInvoiceRequest.toJson());
                                    setState(() {
                                      isApiCallProgress = true;
                                    });
                                    PayInvoiceResponseModel payInvoiceResponse =await PayInvoiceApi().payInvoice(localData.token, payInvoiceRequest);
                                    setState(() {
                                      isApiCallProgress = false;
                                    });
                                    if(payInvoiceResponse!=null){
                                      Fluttertoast.showToast(msg: payInvoiceResponse.message);
                                      if(payInvoiceResponse.status==1){
                                        Get.to(()=>SuccessScreen(
                                          message: payInvoiceResponse.message,
                                          transactionId: payInvoiceResponse.transactionNumber,
                                          balance: sum.toString(),
                                        ));
                                      }
                                    }else{
                                      Fluttertoast.showToast(msg: 'Something went wrong');
                                    }
                                  }
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

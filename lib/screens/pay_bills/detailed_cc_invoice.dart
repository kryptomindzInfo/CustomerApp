import 'package:beyond_wallet/api_services/check_bill_fee_api.dart';
import 'package:beyond_wallet/api_services/get_merchant_penalty_rule_api.dart';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/get_invoice_by_cc_model.dart';
import 'package:beyond_wallet/models/get_merchant_penalty_rule_model.dart';
import 'package:beyond_wallet/models/check_bill_fee_model.dart';
import 'package:beyond_wallet/services/shared_prefs.dart';
import 'package:beyond_wallet/widgets/Loader.dart';
import 'package:beyond_wallet/widgets/appBar.dart';
import 'package:beyond_wallet/widgets/button.dart';
import 'package:beyond_wallet/widgets/sucess_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:beyond_wallet/models/pay_invoice_model.dart';
import 'package:beyond_wallet/api_services/pay_invoice_api.dart';
class CCInvoiceDetails extends StatefulWidget {

  final CcInvoice invoices;
  CCInvoiceDetails({this.invoices});

  @override
  _CCInvoiceDetailsState createState() => _CCInvoiceDetailsState();
}

class _CCInvoiceDetailsState extends State<CCInvoiceDetails> {

  int totalAmount=0;
  double totalTax = 0;
  Future<CheckBillFeeResponseModel> _checkBillFee;
  Future<GetMerchantPenaltyRuleResponseModel> _getPenalty;
  bool isApiCallProgress = false;
  double fee;
  int penalty;
  LocalData localData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetMerchantPenaltyRuleRequestModel penaltyRuleRequestModel = new GetMerchantPenaltyRuleRequestModel();
    penaltyRuleRequestModel.merchantId = widget.invoices.merchantId;
    localData = Provider.of<LocalData>(context,listen: false);
    _getPenalty = GetMerchantPenaltyRuleApi().getMerchantPenaltyRule(penaltyRuleRequestModel, localData.token);

    for(Item item in widget.invoices.items){
      totalAmount =totalAmount+ item.quantity * item.itemDesc.unitPrice;
      totalTax = totalTax + ((item.taxDesc.value/100)*(item.quantity*item.itemDesc.unitPrice));
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.invoices.name.toString());
    return isApiCallProgress?Loader():Scaffold(
      appBar: appBar(
          'Pay ${widget.invoices.name} Bills', context, true),
      body:FutureBuilder<GetMerchantPenaltyRuleResponseModel>(
          future:_getPenalty,
          builder: (context, penaltySnapshot) {
            if(penaltySnapshot.hasData){
              penalty = penaltySnapshot.data.rule.fixedAmount;
              CheckBillFeeRequestModel requestModel = new CheckBillFeeRequestModel();
              requestModel.amount = widget.invoices.amount + penalty;
              requestModel.merchantId = widget.invoices.merchantId;
              _checkBillFee = CheckBillFeeApi().checkBillFee(requestModel, localData.token);
            }
            return FutureBuilder<CheckBillFeeResponseModel>(
                future:_checkBillFee,
                builder: (context, feeSnapshot) {
                  if(feeSnapshot.hasData){
                    fee = feeSnapshot.data.fee;
                  }
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                    children: [
                                      title('Customer Code '),
                                      value(widget.invoices.customerCode)
                                    ]
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                    children: [
                                      title('Due Date '),
                                      value(widget.invoices.dueDate)
                                    ]
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                    children: [
                                      title('Mobile '),
                                      value(widget.invoices.mobile)
                                    ]
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                    children: [
                                      title('Bill Date '),
                                      value(widget.invoices.billDate)
                                    ]
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                    children: [
                                      title('Bill No '),
                                      value(widget.invoices.number)
                                    ]
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                    children: [
                                      title('Period '),
                                      value(widget.invoices.billPeriod.periodName.toString())
                                    ]
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30.0,),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget.invoices.items.length,
                              itemBuilder: (context,index) {
                                return Card(
                                  child: Container(
                                    height: 200,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Name : ${widget.invoices.items[index].itemDesc.name}',
                                              style: TextStyle(
                                                  fontSize: 15.0
                                              ),
                                            ),
                                            Text(
                                              'Code : ${widget.invoices.items[index].itemDesc.code}',
                                              style: TextStyle(
                                                  fontSize: 15.0
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20.0,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Unit of measure : ${widget.invoices.items[index].itemDesc.unitOfMeasure}',
                                              style: TextStyle(
                                                  fontSize: 15.0
                                              ),
                                            ),
                                            Text(
                                              'Unit price : ${widget.invoices.items[index].itemDesc.unitPrice}',
                                              style: TextStyle(
                                                  fontSize: 15.0
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20.0,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Quantity : ${widget.invoices.items[index].quantity}',
                                              style: TextStyle(
                                                  fontSize: 15.0
                                              ),
                                            ),
                                            Text(
                                              'Amount : ${widget.invoices.items[index].quantity*widget.invoices.items[index].itemDesc.unitPrice}',
                                              style: TextStyle(
                                                  fontSize: 15.0
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20.0,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Tax % : ${widget.invoices.items[index].taxDesc.value}',
                                              style: TextStyle(
                                                  fontSize: 15.0
                                              ),
                                            ),
                                            Text(
                                              'Amount with tax : ${widget.invoices.items[index].totalAmount}',
                                              style: TextStyle(
                                                  fontSize: 15.0
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20.0,),
                                        Text(
                                          'Description : ${widget.invoices.items[index].itemDesc.description}',
                                          style: TextStyle(
                                              fontSize: 15.0
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                          ),
                          RichText(
                            text: TextSpan(
                                children: [
                                  title('Total Amount '),
                                  value(totalAmount.toString())
                                ]
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          RichText(
                            text: TextSpan(
                                children: [
                                  title('Total Tax '),
                                  value(totalTax.toString())
                                ]
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          RichText(
                            text: TextSpan(
                                children: [
                                  title('Total Fees '),
                                  value(fee!=null?fee.toString():'NA')
                                ]
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          RichText(
                            text: TextSpan(
                                children: [
                                  title('Penalty '),
                                  value(penalty!=null?penalty.toString():'NA')
                                ]
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          RichText(
                            text: TextSpan(
                                children: [
                                  title('Total Sum '),
                                  value(
                                      fee!=null&&penalty!=null ? (fee+totalTax+totalAmount).toString() : "NA"
                                  )
                                ]
                            ),
                          ),
                          SizedBox(height: 70.0,),
                          fee!=null&&penalty!=null?GreenButton(
                            text: 'Collect XOF ${fee+totalTax+totalAmount} and Pay Bill',
                            onClicked: () async {
                              Invoice invoice= new Invoice();
                              PayInvoiceRequestModel payInvoiceRequest = new PayInvoiceRequestModel();
                              payInvoiceRequest.merchantId = widget.invoices.merchantId;
                              invoice.id = widget.invoices.id;
                              invoice.penalty = penalty;
                              List<Invoice> invoices =[invoice];
                              payInvoiceRequest.invoices = invoices;
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
                                    balance: (fee+totalTax+totalAmount).toString(),
                                  ));
                                }
                              }else{
                                Fluttertoast.showToast(msg: 'Something went wrong');
                              }

                            },
                          ): Center(
                            child: Text(
                              "Can't process transaction right now",
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
            );
          }
      ),
    );
  }
  TextSpan title(String text){
    return TextSpan(
        text: text,
        style: TextStyle(
            color: Colors.black,
            fontSize: 18.0
        )
    );
  }
  TextSpan value(String text){
    return TextSpan(
      text: text,
      style: TextStyle(
          color: primaryColor,
          fontSize: 18.0,
          fontWeight: FontWeight.bold
      ),
    );
  }
}
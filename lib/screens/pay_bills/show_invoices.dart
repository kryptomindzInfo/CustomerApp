import 'package:beyond_wallet/api_services/get_invoice_by_cc_api.dart';
import 'package:beyond_wallet/api_services/get_invoice_by_mobile_api.dart';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/get_invoice_by_cc_model.dart';
import 'package:beyond_wallet/models/get_invoice_by_mobile_model.dart';
import 'package:beyond_wallet/services/shared_prefs.dart';
import 'package:beyond_wallet/widgets/Loader.dart';
import 'package:beyond_wallet/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:beyond_wallet/screens/pay_bills/detailed_invoice.dart';
class ShowInvoices extends StatefulWidget {
  final String merchantId;
  final String type;
  final String number;

  ShowInvoices({this.merchantId, this.type, this.number});

  @override
  _ShowInvoicesState createState() => _ShowInvoicesState();
}

class _ShowInvoicesState extends State<ShowInvoices> {

  Future _getInvoices;
  List<Invoices> invoices=[];
  GetInvoiceByMobileRequestModel mobileRequestModel;
  GetInvoiceByCcRequestModel getInvoiceByCcRequestModel;
  LocalData localData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localData = Provider.of<LocalData>(context,listen: false);
    mobileRequestModel= new GetInvoiceByMobileRequestModel();
    mobileRequestModel.merchantId= widget.merchantId;
    mobileRequestModel.mobile= widget.number;
  }
  @override
  Widget build(BuildContext context) {
    _getInvoices = GetInvoiceByMobileApi().getInvoiceByMobile(mobileRequestModel, localData.token);
    return Scaffold(
      appBar: appBar('Invoices', context,true),
      body:FutureBuilder<GetInvoiceByMobileResponseModel>(
        future: _getInvoices,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            print(snapshot.data.toJson());
            for(Invoices invoice in snapshot.data.invoices){
              if(invoice.paid==0){
                invoices.add(invoice);
              }
            }
            return invoices.isEmpty?
            Center(
              child: Text('No Invoices Found'),
            ):ListView.builder(
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
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  invoices[index].name,
                                  style: TextStyle(
                                      fontSize:20.0
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(),
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
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }else{
            return Loader();
          }
        }
      )
    );
  }
}

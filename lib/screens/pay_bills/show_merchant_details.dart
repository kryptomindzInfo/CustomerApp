import 'dart:ui';

import 'package:beyond_wallet/api_services/get_merchant_details_api.dart';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/get_invoice_by_mobile_model.dart';
import 'package:beyond_wallet/models/merchant_details_model.dart';
import 'package:beyond_wallet/screens/pay_bills/detailed_invoice.dart';
import 'package:beyond_wallet/services/shared_prefs.dart';
import 'package:beyond_wallet/widgets/Loader.dart';
import 'package:beyond_wallet/widgets/appBar.dart';
import 'package:beyond_wallet/widgets/networkImage.dart';
import 'package:beyond_wallet/widgets/pay_bill_dialoge.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
class ShowMerchantDetails extends StatefulWidget {
  final String merchantID;
  ShowMerchantDetails({this.merchantID});

  @override
  _ShowMerchantDetailsState createState() => _ShowMerchantDetailsState();
}

class _ShowMerchantDetailsState extends State<ShowMerchantDetails> {

  Future _getMerchantDetails;
  LocalData _localData;
  List searchBy = ['Mobile Number','Bill Number','Customer Code'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MerchantDetailsRequestModel requestModel = new MerchantDetailsRequestModel();
    requestModel.merchantId = widget.merchantID;
    _localData = Provider.of<LocalData>(context,listen: false);
    _getMerchantDetails = MerchantDetailsApi().getMerchantDetails(requestModel, _localData.token);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Merchant details', context,true),
      body: FutureBuilder<MerchantDetailsResponseModel>(
        future: _getMerchantDetails,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            snapshot.data.invoices.removeWhere((element){
              return element['paid']==1;
            });
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: ListTile(
                      leading: networkImage(snapshot.data.merchant.logo),
                      title: Text(
                        snapshot.data.merchant.name
                      ),
                      subtitle: Text(
                        snapshot.data.merchant.description
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Bills List',
                        style: TextStyle(
                          fontSize: 25.0
                        ),
                      ),
                      RaisedButton(
                        onPressed: (){
                          showDialog(
                              context: context,
                              builder: (context)=>PayBillDialoge(
                                merchantID: snapshot.data.merchant.id,
                              )
                          );
                        },
                        color: primaryColor,
                        child: Text(
                          'Pay Other Bill',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: snapshot.data.invoices.isEmpty?
                    Center(
                      child: Text(
                        'No Bills Available'
                      ),
                    ):ListView.builder(
                     itemCount: snapshot.data.invoices.length,
                     itemBuilder: (context,index){
                       return Column(
                         children: [
                           SizedBox(height: 5.0,),
                           InkWell(
                             onTap:(){
                               Invoices invoices = Invoices.fromJson(snapshot.data.invoices[index]);
                               Get.to(()=>InvoiceDetails(
                                 invoices: invoices,
                               ));
                              },
                             child: Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: Card(
                                 child: Container(
                                   height: 100,
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: <Widget>[
                                       Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text(
                                             snapshot.data.invoices[index]['name'],
                                             style: TextStyle(
                                               fontSize:20.0
                                             ),
                                           ),
                                           SizedBox(height: 10.0,),
                                           Text(
                                             snapshot.data.invoices[index]['number'],
                                             style: TextStyle(
                                                 fontSize: 13.0
                                             ),
                                           ),
                                           SizedBox(height: 10.0,),
                                           Text(
                                             'Due Date: ${snapshot.data.invoices[index]['due_date']}',
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
                                           Text(
                                             'Penalty ${snapshot.data.invoices[index]['penalty']??0}',
                                             style: TextStyle(
                                                 fontSize: 15.0
                                             ),
                                           ),
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
                                                       text: snapshot.data.invoices[index]['amount'].toString(),
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
                           ),
                         ],
                       );
                     },
                    ),
                  )
                ],
              ),
            );
          }else{
            return Loader();
          }
        }
      ),
    );
  }
}

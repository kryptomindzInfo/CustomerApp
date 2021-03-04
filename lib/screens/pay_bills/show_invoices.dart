import 'package:beyond_wallet/api_services/get_invoice_by_mobile_api.dart';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/get_invoice_by_mobile_model.dart';
import 'package:beyond_wallet/services/shared_prefs.dart';
import 'package:beyond_wallet/widgets/Loader.dart';
import 'package:beyond_wallet/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ShowInvoices extends StatefulWidget {
  String merchantId;
  String type;
  String number;

  ShowInvoices({this.merchantId, this.type, this.number});

  @override
  _ShowInvoicesState createState() => _ShowInvoicesState();
}

class _ShowInvoicesState extends State<ShowInvoices> {
  
  Future _getInvoices;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocalData localData = Provider.of<LocalData>(context,listen: false);
    GetInvoiceByMobileRequestModel requestModel= new GetInvoiceByMobileRequestModel();
    requestModel.merchantId= widget.merchantId;
    requestModel.mobile= widget.number;
    print(requestModel.toJson());
    _getInvoices = GetInvoiceByMobileApi().getInvoiceByMobile(requestModel, localData.token);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Invoices', context),
      body:FutureBuilder<GetInvoiceByMobileResponseModel>(
        future: _getInvoices,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.invoices.length,
              itemBuilder: (context,index){
                return Padding(
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
                                snapshot.data.invoices[index].name,
                                style: TextStyle(
                                    fontSize:20.0
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              Text(
                                snapshot.data.invoices[index].number,
                                style: TextStyle(
                                    fontSize: 15.0
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              Text(
                                'Due Date: ${snapshot.data.invoices[index].dueDate}',
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
                                'Bill No.',
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
                                        text: snapshot.data.invoices[index].amount.toString(),
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

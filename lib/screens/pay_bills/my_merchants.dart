import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/added_merchant_model.dart';
import 'package:beyond_wallet/models/login_model.dart';
import 'package:beyond_wallet/screens/pay_bills/show_merchant_details.dart';
import 'package:beyond_wallet/screens/pay_bills/show_merchant_list.dart';
import 'package:beyond_wallet/utils/network_util.dart';
import 'package:beyond_wallet/widgets/Loader.dart';
import 'package:beyond_wallet/widgets/networkImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class MyMerchants extends StatefulWidget {
  @override
  _MyMerchantsState createState() => _MyMerchantsState();
}

class _MyMerchantsState extends State<MyMerchants> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: FutureBuilder<Object>(
        future: NetworkUtil.httpGetFuture(
          context: context,
          apiEndPoint: 'user/listAddedMerchants',
        ),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            AddedMerchantResponseModel responseModel = AddedMerchantResponseModel.fromJson(snapshot.data);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: responseModel.list.length,
                itemBuilder: (_,index){
                  return Column(
                    children: [
                      SizedBox(height: 10.0,),
                      Card(
                        child: ListTile(
                          onTap: ()=>Get.to(()=>ShowMerchantDetails(
                            merchantID: responseModel.list[index].id,
                          )),
                          title: Text(responseModel.list[index].name),
                          leading:networkImage(responseModel.list[index].logo),
                          trailing:Text(
                            'View',
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }else{
            return Loader();
          }
        }
      ),
    );
  }

  Widget appBar(){
    return PreferredSize(
      child: new Container(
        height: 120.0,
        width: double.infinity,
        padding: new EdgeInsets.only(
            top: MediaQuery.of(context).padding.top
        ),
        child: new Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap:(){
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              Text(
                'My Merchants',
                style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: InkWell(
                    onTap: (){
                      Get.to(()=>ShowMerchantList()).then((value) => setState((){}));
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
              )
            ],
          ),
        ),
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  endColor,
                  startColor,
                ]
            ),
            boxShadow: [
              new BoxShadow(
                color: Colors.grey[500],
                blurRadius: 20.0,
                spreadRadius: 1.0,
              )
            ]
        ),
      ),
      preferredSize: new Size(
          MediaQuery.of(context).size.width,
          150.0
      ),
    );
  }
}

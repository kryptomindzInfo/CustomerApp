import 'package:beyond_wallet/api_services/assign_bank_api.dart';
import 'package:beyond_wallet/api_services/get_banks_api.dart';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/localization/localization.dart';
import 'package:beyond_wallet/models/assgin_bank_model.dart';
import 'package:beyond_wallet/models/get_banks_model.dart';
import 'package:beyond_wallet/screens/home/upload_documents.dart';
import 'package:beyond_wallet/services/shared_prefs.dart';
import 'package:beyond_wallet/widgets/Loader.dart';
import 'package:beyond_wallet/widgets/appBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SelectBank extends StatefulWidget {
  @override
  _SelectBankState createState() => _SelectBankState();
}

class _SelectBankState extends State<SelectBank> {
  Future<GetBanksResponseModel> _future;
  var localData;
  bool isApiCallProgress = false;
  GetBanksResponseModel response;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localData = Provider.of<LocalData>(context,listen: false);
    _future = GetBanksApi().getBanks(localData.token);
  }
  @override
  Widget build(BuildContext context) {
    var translate = DemoLocalization.of(context);
    return Scaffold(
      appBar: appBar(
        translate.getTranslatedValue('Choose Your Bank'),
        context
      ),
      body: FutureBuilder<GetBanksResponseModel>(
        future: _future,
        builder: (context, snapshot){
          if(snapshot.hasData){
            response = snapshot.data;
            return isApiCallProgress?Loader():ListView.builder(
              itemCount:response.banks.length,
              itemBuilder: (context,index){
                return Column(
                  children: [
                    Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: CachedNetworkImage(
                            imageUrl: imageBaseURL+response.banks[index].logo,
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                CircularProgressIndicator(value: downloadProgress.progress),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                        onTap: _assignBank(index),
                        title: Text(response.banks[index].name),
                      ),
                    ),
                    SizedBox(height: 5.0,)
                  ],
                );
              },
            );
          }else{
            return Loader();
          }
        }
      ),
    );
  }
  Function _assignBank(int index){
    return ()async{
      AssignBankRequestModel requestModel = AssignBankRequestModel();
      requestModel.bankId = response.banks[index].sId;
      setState(() {
        isApiCallProgress = true;
      });
      AssignBankResponseModel assignBankResponseModel =await AssignBankApi().assignBank(requestModel,localData.token);
      if(assignBankResponseModel!=null){
        setState(() {
          isApiCallProgress = false;
        });
        Fluttertoast.showToast(msg: assignBankResponseModel.message);
        if(assignBankResponseModel.status == 1){
          Get.offAll(()=>UploadDocuments());
        }else{
          setState(() {
            isApiCallProgress = false;
          });
        }
      }else{
        setState(() {
          isApiCallProgress = false;
        });
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    };
  }
}


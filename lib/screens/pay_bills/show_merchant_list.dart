import 'package:beyond_wallet/api_services/get_marchents_api.dart';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/get_marchent_list_model.dart';
import 'package:beyond_wallet/services/shared_prefs.dart';
import 'package:beyond_wallet/widgets/Loader.dart';
import 'package:beyond_wallet/widgets/appBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ShowMerchantList extends StatefulWidget {
  @override
  _ShowMerchantListState createState() => _ShowMerchantListState();
}

class _ShowMerchantListState extends State<ShowMerchantList> {
  Future _getMerchantList;
  LocalData _localData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _localData = Provider.of<LocalData>(context,listen: false);
    _getMerchantList = GetMerchantListApi().getMerchantList(_localData.token);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        'Merchant List',
        context
      ),
      body: FutureBuilder<GetMerchantListResponseModel>(
        future: _getMerchantList,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.list.length,
              itemBuilder: (context,index){
                return Column(
                  children: [
                    Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.0),
                            child: CachedNetworkImage(
                              imageUrl: imageBaseURL+snapshot.data.list[index].logo,
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  CircularProgressIndicator(value: downloadProgress.progress),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                        ),
                        title: Text(
                          snapshot.data.list[index].name
                        ),
                        subtitle: Text(
                            snapshot.data.list[index].email
                        ),
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
}

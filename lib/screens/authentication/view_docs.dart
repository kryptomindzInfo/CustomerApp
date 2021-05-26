import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/utils/network_util.dart';
import 'package:beyond_wallet/widgets/Loader.dart';
import 'package:beyond_wallet/widgets/appBar.dart';
import 'package:beyond_wallet/widgets/networkImage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class ViewDocs extends StatefulWidget {
  @override
  _ViewDocsState createState() => _ViewDocsState();
}

class _ViewDocsState extends State<ViewDocs> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Documents', context, true),
      body: FutureBuilder(
        future: NetworkUtil.httpGetFuture(apiEndPoint: 'user/getDetails',context: context),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Center(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data['user']['docs_hash'].length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: docBaseUrl+snapshot.data['user']['docs_hash'][index]['hash'],
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 20.0,),
                        Text(
                            snapshot.data['user']['docs_hash'][index]['name']
                        )
                      ],
                    ),
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
}

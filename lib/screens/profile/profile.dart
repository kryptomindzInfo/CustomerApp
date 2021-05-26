import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/login_model.dart';
import 'package:beyond_wallet/screens/authentication/change_password.dart';
import 'package:beyond_wallet/screens/authentication/view_docs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  LoginResponseModel responseModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    responseModel = Get.find<LoginResponseModel>();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: new Container(
          width: double.infinity,
          padding: new EdgeInsets.only(
              top: MediaQuery.of(context).padding.top
          ),
          child: new Padding(
            padding: const EdgeInsets.only(
                left: 10.0,
                top: 10.0,
                bottom: 10.0
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:10.0,right: 10.0),
                  child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back,color: Colors.white,)
                  ),
                ),
                Row(
                  children: [
                    new Text(
                      'Profile',
                      style: new TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: PopupMenuButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                        color: Colors.white,
                        onSelected: (val){
                          switch(val){
                            case 'changePassword':
                              Get.to(()=>ChangePassword());
                              break;
                            case 'viewDocs':
                              Get.to(()=>ViewDocs());
                              break;
                          }
                        },
                        itemBuilder: (_) => <PopupMenuItem<String>>[
                          PopupMenuItem<String>(
                              value: 'changePassword',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.vpn_key,
                                  ),
                                  SizedBox(width: 10.0,),
                                  new Text('Change Password'),
                                ],
                              )),
                          PopupMenuItem<String>(
                              value: 'viewDocs',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.attach_money,
                                  ),
                                  SizedBox(width: 10.0,),
                                  new Text('View Documents'),
                                ],
                              )),
                        ]
                    )
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Status : ${"Verified"}',
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
                SizedBox(width: 10.0,),
                Icon(Icons.verified,color: primaryColor,)
              ],
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              readOnly: true,
              decoration: inputDecoration.copyWith(
                labelText: 'Username'
              ),
              initialValue: responseModel.user.username,
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              readOnly: true,
              decoration: inputDecoration.copyWith(
                  labelText: 'Email'
              ),
              initialValue: responseModel.user.email,
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              readOnly: true,
              decoration: inputDecoration.copyWith(
                  labelText: 'Address'
              ),
              initialValue: responseModel.user.address,
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              readOnly: true,
              decoration: inputDecoration.copyWith(
                  labelText: 'Mobile'
              ),
              initialValue: responseModel.user.mobile,
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              readOnly: true,
              decoration: inputDecoration.copyWith(
                  labelText: 'Name'
              ),
              initialValue: responseModel.user.name,
            ),

          ],
        ),
      ),
    );
  }
}

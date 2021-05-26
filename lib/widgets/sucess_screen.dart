import 'dart:io';
import 'dart:typed_data';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/controller/balance_controller.dart';
import 'package:beyond_wallet/screens/home/home_screen.dart';
import 'package:beyond_wallet/services/shared_prefs.dart';
import 'package:beyond_wallet/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class SuccessScreen extends StatefulWidget {
  final String message;
  final String transactionId;
  final String balance;

  SuccessScreen({this.message,this.balance,this.transactionId});

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    BalanceController getBalance = Provider.of<BalanceController>(context);
    LocalData localData = Provider.of<LocalData>(context);
    return Scaffold(
      body: Screenshot(
        controller: screenshotController,
        child: Container(
          color: Colors.white,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 150,
                      width: 150,
                      child: Lottie.asset(
                          'assets/lottie/sucess.json',
                        repeat: false
                      )
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25.0,
                            color: primaryColor,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      widget.balance!=null?Text(
                        "${widget.balance} XOF",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: primaryColor,
                            fontWeight: FontWeight.bold
                        ),
                      ):Offstage(),
                      SizedBox(height: 30.0,),
                      Text(
                        getDateForSuccessScreen(DateTime.now()),
                        style: TextStyle(
                            fontSize: 15.0,
                            color: primaryColor,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 30.0,),
                      widget.transactionId==null?Offstage():Text(
                        'Transaction ID: ${widget.transactionId}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: primaryColor,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.share,color: primaryColor,),
                            onPressed: () async {
                              var dir =await getExternalStorageDirectory();
                              final imageFile =await screenshotController.capture();
                              File file = File(dir.path+'/screenshot.png');
                              await file.writeAsBytes(imageFile);
                              Share.shareFiles([file.path]);
                            }, 
                          ),
                          SizedBox(width: 20.0,),
                          IconButton(
                            icon: Icon(Icons.download_sharp,color:primaryColor,),
                            onPressed: () async {
                              var dir =await getExternalStorageDirectory();
                              final imageFile =await screenshotController.capture();
                              final permission = await Permission.storage.request();
                              if(permission.isGranted){
                                print(dir.path);
                                File file = File('/storage/emulated/0/Download/'+'${widget.transactionId}.png');
                                file.writeAsBytes(imageFile);
                                Fluttertoast.showToast(msg: 'Saved To Downloads');
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  GreenButton(
                    text: 'Done',
                    onClicked: (){
                      getBalance.getBalanceController(localData.token);
                      Get.offAll(()=>HomeScreen(balanceController: getBalance,));
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

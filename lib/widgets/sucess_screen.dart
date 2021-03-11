import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/controller/balance_controller.dart';
import 'package:beyond_wallet/screens/home/home_screen.dart';
import 'package:beyond_wallet/services/shared_prefs.dart';
import 'package:beyond_wallet/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SuccessScreen extends StatelessWidget {
  final String message;
  final double balance;
  SuccessScreen({this.message,this.balance});
  @override
  Widget build(BuildContext context) {
    BalanceController getBalance = Provider.of<BalanceController>(context);
    LocalData localData = Provider.of<LocalData>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 150,
                  width: 150,
                  child: Lottie.asset(
                      'assets/lottie/sucess.json',
                    repeat: false
                  )
              ),
              SizedBox(height: 250.0,),
              Center(
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: primaryColor,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 30.0,),
              Text(
                'Current Balance: $balance',
                style: TextStyle(
                    fontSize: 20.0,
                    color: primaryColor,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 30.0,),
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
    );
  }
}

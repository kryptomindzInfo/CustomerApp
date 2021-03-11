import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/screens/send_money/send_money_to_non_wallet.dart';
import 'package:beyond_wallet/screens/send_money/send_money_to_wallet.dart';
import 'package:beyond_wallet/widgets/appBar.dart';
import 'package:flutter/material.dart';
class SendMoney extends StatefulWidget {
  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney>  with SingleTickerProviderStateMixin{
  bool toWallet = true;
  bool toNonWallet = false;
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: Colors.white
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          backgroundColor: endColor,
          title: Text('Send Money',style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight:FontWeight.bold),),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black87,
            indicatorColor:Colors.white,
            tabs: [
              Tab(text:'To Wallet'),
              Tab(text: 'To Non Wallet')
            ],
          ),
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      toWallet = true;
                      toNonWallet = false;
                    });
                  },
                  child: Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                      color: toWallet?primaryColor:Colors.white,
                        borderRadius:BorderRadius.only(topLeft: Radius.circular(5.0),bottomLeft:Radius.circular(5.0) ),
                        border: Border.all(
                          width: 2.0,
                          color: primaryColor,
                        )
                    ),
                    child: Center(
                      child: Text(
                        'To Wallet',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: toWallet?Colors.white:primaryColor
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      toWallet = false;
                      toNonWallet = true;
                    });
                  },
                  child: Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                        color: toNonWallet?primaryColor:Colors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(5.0),bottomRight:Radius.circular(5.0) ),
                        border: Border.all(
                          width: 2.0,
                          color: primaryColor,
                        )
                      ),
                    child: Center(
                      child: Text(
                        'To Non Wallet',
                        style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: toNonWallet?Colors.white:primaryColor
                        ),
                      ),
                    ),
                    ),
                )
              ],
            ),
            SizedBox(height: 30.0,),
            toWallet?SendMoneyToWallet():SendMoneyToNonWallet()
          ],
        ),
      ),
    );
  }
}

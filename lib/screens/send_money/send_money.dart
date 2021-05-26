import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/screens/send_money/send_money_to_non_wallet.dart';
import 'package:beyond_wallet/screens/send_money/send_money_to_wallet.dart';
import 'package:beyond_wallet/widgets/appBar.dart';
import 'package:flutter/material.dart';
class SendMoney extends StatefulWidget {
  final Map contact;

  const SendMoney({Key key, this.contact}) : super(key: key);
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
    if(widget.contact!=null&&widget.contact['type']=='nw'){
      _tabController.animateTo(1);
    }
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
            controller: _tabController,
            labelColor: Colors.white,
            indicatorColor:Colors.white,
            tabs: [
              Tab(text:'To Wallet'),
              Tab(text: 'To Non Wallet')
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            SendMoneyToWallet(contact: widget.contact,),
            SendMoneyToNonWallet(contact: widget.contact,)
          ],
        )
      ),
    );
  }
}

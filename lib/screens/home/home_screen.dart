import 'package:auto_size_text/auto_size_text.dart';
import 'package:beyond_wallet/api_services/get_balance_api.dart';
import 'package:beyond_wallet/api_services/get_contacts_api.dart';
import 'package:beyond_wallet/api_services/get_transaction_history_api.dart';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/controller/balance_controller.dart';
import 'package:beyond_wallet/controller/get_banks_controller.dart';
import 'package:beyond_wallet/localization/localization.dart';
import 'package:beyond_wallet/models/get_balance_model.dart';
import 'package:beyond_wallet/models/get_contacts_model.dart';
import 'package:beyond_wallet/models/get_transaction_history_model.dart';
import 'package:beyond_wallet/models/login_model.dart';
import 'package:beyond_wallet/screens/authentication/login.dart';
import 'package:beyond_wallet/screens/pay_bills/show_merchant_list.dart';
import 'package:beyond_wallet/screens/send_money/send_money.dart';
import 'package:beyond_wallet/services/shared_prefs.dart';
import 'package:beyond_wallet/widgets/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
class HomeScreen extends StatefulWidget {
  final BalanceController balanceController;
  HomeScreen({this.balanceController});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var width;
  var height;
  var translate;
  LocalData localData;
  Future _getContacts;
  Future _getTransactionHistory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localData = Provider.of<LocalData>(context,listen: false);
    _getContacts = GetContactsApi().getContacts(localData.token);
    _getTransactionHistory = GetTransactionHistoryApi().getTransactionHistory(localData.token);
  }
  String _getInitials(String text){
    return text.substring(0,2).toUpperCase();
  }
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    widget.balanceController.getBalanceController(localData.token);
    _refreshController.refreshCompleted();
    _getContacts = GetContactsApi().getContacts(localData.token);
    _getTransactionHistory = GetTransactionHistoryApi().getTransactionHistory(localData.token);
  }

  void _onLoading() async{
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }
  @override
  Widget build(BuildContext context) {
    BalanceController getBalance = Provider.of<BalanceController>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    translate = DemoLocalization.of(context);
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
                top: 20.0,
                bottom: 20.0
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new Text(
                  'Dashboard',
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
                        Get.offAll(()=>Login());
                      },
                      child: Icon(Icons.logout,color: Colors.white,)
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
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text("pull up load");
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
              body = Text("release to load more");
            }
            else{
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              BaseTile(
                 child:Padding(
                   padding: const EdgeInsets.symmetric(vertical: 10),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: <Widget>[
                       _balanceWidget(getBalance),
                       RoundButton(
                         child: Container(
                           height: 30,
                           child: SvgPicture.asset(
                             'assets/images/send_money.svg',
                             color: Colors.white,
                           ),
                         ),
                         color: primaryColor,
                         text: 'Send Money',
                         function: (){
                           Get.to(()=>SendMoney());
                         },
                       ),
                       RoundButton(
                         child: Container(
                           height: 30,
                           child: SvgPicture.asset(
                             'assets/images/pay_bill.svg',
                             color: Colors.white,
                           ),
                         ),
                         color: primaryColor,
                         text: 'Pay Bills',
                         function: (){
                           Get.to(()=>ShowMerchantList());
                         },
                       )
                     ],
                   ),
                 ),
              ),
              SizedBox(height: 10.0,),
              BaseTile(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder<GetContactsResponseModel>(
                    future: _getContacts,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        List<String> contacts=[];
                        for(Wallet contact in snapshot.data.contacts.wallet){
                          contacts.add(contact.name);
                        }
                        for(NonWallet contact in snapshot.data.contacts.nonWallet){
                          contacts.add(contact.name);
                        }
                        return Column(
                          crossAxisAlignment : CrossAxisAlignment.start,
                          //mainAxisAlignment : MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Contacts',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: contacts.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context,index){
                                  return Row(
                                    children: [
                                      RoundButton(
                                        child: Text(
                                          _getInitials(contacts[index]),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25.0
                                          ),
                                        ),
                                        fontColor: Colors.black,
                                        function: (){},
                                        text: contacts[index],
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 10.0,)
                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        );
                      }else{
                        return Container(
                             height: 40,
                            width: 40,
                        );
                      }
                    }
                ),
              ),
              SizedBox(height: 10.0,),
              Expanded(
                child: BaseTile(
                  child: Column(
                    children: [
                      Container(
                        height:70.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                                backgroundColor: primaryColor,
                                radius: 30.0,
                                child: Text(
                                    _getInitials(localData.data.name),
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.white
                                  ),
                                ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  'Recent Activity',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                  ),
                                ),
                                subtitle: Text(
                                  'E-wallet Activity'
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder<GetTransactionHistoryResponseModel>(
                          future:_getTransactionHistory,
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              int lastIndex = snapshot.data.history.length-1;
                              return ListView.builder(
                                itemCount: snapshot.data.history.length,
                                itemBuilder: (context,index){
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: BaseTile(
                                          child: ListTile(
                                              title: Text(
                                                snapshot.data.history[lastIndex-index].value.remarks,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              subtitle:Text(
                                                  DateTime.parse(snapshot.data.history[lastIndex-index].timestamp.substring(0,19)).toLocal().toString()
                                              ),
                                              trailing: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  AutoSizeText(
                                                    snapshot.data.history[lastIndex-index].value.amount.toString(),
                                                    maxLines :1,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 25.0
                                                    ),
                                                  ),
                                                  Text(
                                                    snapshot.data.history[lastIndex-index].value.action,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15.0,
                                                        color: Colors.green
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }else{
                              return Center(child: Container(height:40,width:40,child: CircularProgressIndicator()));
                            }
                          }
                        ),
                      )

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget _balanceWidget(BalanceController balance){
    return Container(
      padding: EdgeInsets.all(10.0),
      width: width * 0.38 ,
      height: 100,
      decoration: BoxDecoration(
        color: balanceTileColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            translate.getTranslatedValue('My Balance'),
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white
            ),
          ),
          balance.loading?Center(child: CircularProgressIndicator()):AutoSizeText(
            balance.balance.toString(),
            maxLines: 1,
            style: TextStyle(
                fontSize: 35.0,
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function function;
  final Widget child;
  final Color fontColor;

  RoundButton({this.color, this.text, this.function, this.child,this.fontColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        height: 100.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Center(child: child),
            ),
            Text(
              text,
              style: TextStyle(
                  color: fontColor!=null?fontColor:color,
                  fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BaseTile extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  BaseTile({this.child,this.width,this.height});
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.white,
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
          height: height,
          width: width,
          padding: EdgeInsets.all(10.0),
          child: child),
    );
  }
}


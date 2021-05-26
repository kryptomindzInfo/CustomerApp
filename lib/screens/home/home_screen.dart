import 'package:auto_size_text/auto_size_text.dart';
import 'package:beyond_wallet/api_services/get_contacts_api.dart';
import 'package:beyond_wallet/api_services/get_transaction_history_api.dart';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/controller/balance_controller.dart';
import 'package:beyond_wallet/localization/localization.dart';
import 'package:beyond_wallet/models/get_contacts_model.dart';
import 'package:beyond_wallet/models/get_transaction_history_model.dart';
import 'package:beyond_wallet/models/login_model.dart';
import 'package:beyond_wallet/screens/authentication/login.dart';
import 'package:beyond_wallet/screens/pay_bills/my_merchants.dart';
import 'package:beyond_wallet/screens/profile/profile.dart';
import 'package:beyond_wallet/screens/reports/reports.dart';
import 'package:beyond_wallet/screens/send_money/send_money.dart';
import 'package:beyond_wallet/services/shared_prefs.dart';
import 'package:beyond_wallet/widgets/networkImage.dart';
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
  LoginResponseModel _loginResponseModel;
  Future _getContacts;
  Future _getTransactionHistory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localData = Provider.of<LocalData>(context,listen: false);
    _getContacts = GetContactsApi().getContacts(localData.token);
    _loginResponseModel = Get.find<LoginResponseModel>();
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
    setState(() {});
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
          height: height*0.13,
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
                Row(
                  children: <Widget>[
                    Container(
                      child:networkImage(_loginResponseModel.bank.logo),
                    ),
                    SizedBox(width: 20.0,),
                    new Text(
                      _loginResponseModel.bank.name,
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
                          case 'reports':
                            Get.to(()=>Reports());
                            break;
                          case 'myBanks':
                            break;
                          case 'notifications':
                            break;
                          case 'profile':
                            Get.to(()=>Profile());
                            break;
                          case 'logout':
                            Get.offAll(()=>Login());
                            break;
                        }
                      },
                      itemBuilder: (_) => <PopupMenuItem<String>>[
                        PopupMenuItem<String>(
                            value: 'reports',
                            child: Row(
                              children: [
                                Icon(
                                    Icons.assignment,
                                ),
                                SizedBox(width: 10.0,),
                                new Text('Reports'),
                              ],
                            )),
                        PopupMenuItem<String>(
                            value: 'myBanks',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.attach_money,
                                ),
                                SizedBox(width: 10.0,),
                                new Text('My Banks'),
                              ],
                            )),
                        PopupMenuItem<String>(
                            value: 'notifications',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.notifications,
                                ),
                                SizedBox(width: 10.0,),
                                new Text('Notifications'),
                              ],
                            )),
                        PopupMenuItem<String>(
                            value: 'profile',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person,
                                ),
                                SizedBox(width: 10.0,),
                                new Text('My Profile'),
                              ],
                            )),
                        PopupMenuItem<String>(
                            value: 'logout',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                ),
                                SizedBox(width: 10.0,),
                                new Text('Logout'),
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
                 child:Row(
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
                       text: 'My Merchants',
                       function: (){
                         Get.to(()=>MyMerchants());
                       },
                     )
                   ],
                 ),
                height: height * 0.17,
              ),
              SizedBox(height: 10.0,),
              BaseTile(
                height: height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder<GetContactsResponseModel>(
                    future: _getContacts,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        List<Map> contacts=[];
                        for(Wallet contact in snapshot.data.contacts.wallet){
                          contacts.add({
                            'name' : contact.name,
                            'walletId' : contact.id,
                            'mobile' : contact.mobile,
                            'type' : 'ww'
                          });
                        }
                        for(NonWallet contact in snapshot.data.contacts.nonWallet){
                          contacts.add({
                            'name' : contact.name,
                            'walletId' : contact.id,
                            'mobile' : contact.mobile,
                            'lastName' : contact.lastName,
                            'email' : contact.email,
                            'country' : contact.country,
                            'type' : 'nw'
                          });
                        }
                        return Column(
                          crossAxisAlignment : CrossAxisAlignment.start,
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
                                          _getInitials(contacts[index]['name']),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25.0
                                          ),
                                        ),
                                        fontColor: Colors.black,
                                        function: (){
                                          Get.to(()=>SendMoney(
                                            contact: contacts[index],
                                          ));
                                        },
                                        text: contacts[index]['name'],
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
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                                backgroundColor: primaryColor,
                                radius: 25.0,
                                child: Text(
                                    _getInitials(localData.data.name),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white
                                  ),
                                ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: AutoSizeText(
                                  'My Activities',
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
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
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: BaseTile(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.baseline,
                                        textBaseline:TextBaseline.alphabetic,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  AutoSizeText(
                                                    snapshot.data.history[lastIndex-index].value.txData[0].remarks,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                    maxLines: 1,
                                                  ),
                                                  Text(
                                                      convertDateTime(DateTime.parse(snapshot.data.history[lastIndex-index].timestamp.substring(0,19)).toLocal())
                                                  ),
                                                ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              AutoSizeText(
                                                snapshot.data.history[lastIndex-index].value.txData[0].amount.toString(),
                                                maxLines :1,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0
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
                                          ),

                                        ],
                                      ),
                                      height: height*0.1,
                                    ),
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
      height: height * 0.12,
      decoration: BoxDecoration(
        color: balanceTileColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          AutoSizeText(
            translate.getTranslatedValue('My Balance'),
            maxLines: 1,
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white
            ),
          ),
          balance.loading?Center(child: CircularProgressIndicator()):Expanded(
            child: AutoSizeText(
              balance.balance.toString(),
              maxLines: 1,
              style: TextStyle(
                  fontSize: 35.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
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
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: function,
      child: Container(
        height: height * 0.12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              height: height * 0.08,
              width: height * 0.08,
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


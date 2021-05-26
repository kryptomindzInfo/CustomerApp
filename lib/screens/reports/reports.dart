import 'package:beyond_wallet/api_services/get_transaction_history_api.dart';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/controller/report_controller.dart';
import 'package:beyond_wallet/models/get_transaction_history_model.dart';
import 'package:beyond_wallet/screens/reports/report_desc_dialogue.dart';
import 'package:beyond_wallet/services/shared_prefs.dart';
import 'package:beyond_wallet/widgets/Loader.dart';
import 'package:beyond_wallet/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Reports extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  Future _getTransactionHistory;
  LocalData localData;
  ReportController _controller;
  @override
  void initState() {
    // TODO: implement initState
    localData = Provider.of<LocalData>(context,listen: false);
    super.initState();
    _getTransactionHistory = GetTransactionHistoryApi().getTransactionHistory(localData.token);
    _controller = Get.put(ReportController());
    _controller.getReports(localData.token);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Reports', context, true),
      body:GetBuilder(
        init: _controller,
        builder: (context) {
          print(_controller.historyList);
          if(_controller.historyList==null){
            return Loader();
          }else{
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  SizedBox(height: 20.0,),
                  Row(
                    children: [
                      dateWidget('fromDate',_controller.fromDate),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:8.0),
                        child: Text('To'),
                      ),
                      dateWidget('toDate',_controller.toDate),
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          decoration: inputDecoration.copyWith(
                              labelText:'Transaction Type'
                          ),
                          items:['All Transactions','Send Money To Wallet','Send Money To Non Wallet','Received Money From Non Wallet','Bill Payments'].map((opr){
                            return DropdownMenuItem(
                              value: opr,
                              child: Text(
                                opr,
                              ),
                            );
                          }).toList(),
                          onChanged: (val){
                            _controller.setTransactionType(val);
                          },
                        ),
                      ),
                      SizedBox(width: 10.0,),
                      Expanded(
                        flex: 1,
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          decoration: inputDecoration.copyWith(
                              labelText:'Select Contact'
                          ),
                          items:_controller.contacts.map((opr){
                            return DropdownMenuItem(
                              value: opr,
                              child: Text(
                                opr['name'],
                              ),
                            );
                          }).toList(),
                          onChanged: (val){
                            setState(() {
                              //type = val;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20.0,),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _controller.filteredList.length,
                      itemBuilder: (context,index){
                        return Card(
                          child: ListTile(
                            onTap: (){
                              showDialog(context: context, builder: (context)=>ReportDescDialog(history: _controller.filteredList[index],));
                            },
                            title: Text(_controller.filteredList[index].value.txData[0].txDetails),
                            subtitle: Text(_controller.filteredList[index].timestamp.substring(0,10)),
                            trailing: Text("XOF ${_controller.filteredList[index].value.txData[0].amount}"),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: 50.0,
                    child: Row(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: (){
                            _controller.decrementPage();
                          },
                          color:primaryColor,
                          child: Text('Previous'),
                        ),
                        SizedBox(width: 5.0,),
                        Container(
                          padding: EdgeInsets.all(5.0),
                          child: Text("${_controller.pageNumber}/${(_controller.historyList.length/10).ceil()}"),
                        ),
                        SizedBox(width: 5.0,),
                        RaisedButton(
                          onPressed: (){
                              _controller.incrementPage();
                          },
                          color:primaryColor,
                          child: Text('Next'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        }
      )
    );
  }
  Future<Null> selectToDate(BuildContext context)async{
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if(picked !=null && picked!=DateTime.now()){
      // toDate = picked;
      // update();
    }
  }

  Widget dateWidget(String operation, DateTime dateTime){
    return Expanded(
        flex: 1,
        child: InkWell(
          onTap: () async {
            if(operation == 'toDate'){
              await _controller.selectToDate(context);
            }else{
              await _controller.selectFromDate(context);
            }
          },
          child: Container(
            height: 50.0,
            decoration: BoxDecoration(
                border: Border.all(color:primaryColor,width: 2.0),
                borderRadius: BorderRadius.circular(5.0)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                dateTime==null?Text('Select Date'):Text(
                  dateTime.toString().substring(0,10),
                  style: TextStyle(
                      fontSize: 16.0
                  ),
                ),
                Icon(
                    Icons.calendar_today_outlined
                )
              ],
            ),
          ),
        ));
  }
}

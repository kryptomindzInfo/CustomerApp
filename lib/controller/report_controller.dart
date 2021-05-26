import 'package:beyond_wallet/api_services/get_contacts_api.dart';
import 'package:beyond_wallet/api_services/get_transaction_history_api.dart';
import 'package:beyond_wallet/models/get_contacts_model.dart';
import 'package:beyond_wallet/models/get_transaction_history_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReportController extends GetxController{
  GetTransactionHistoryResponseModel responseModel;
  DateTime toDate=DateTime.now();
  DateTime fromDate=DateTime.now();
  String transactionType = 'All Transactions';
  List<Map> contacts=[];
  List<History> historyList;
  List<History> filteredList=[];
  List<History> filteredFromDateList=[];
  int pageNumber = 1;

  @override
  onInit(){
    super.onInit();
  }
  
  getContacts(String token){
    GetContactsApi().getContacts(token).then((value){
      for(Wallet wallet in value.contacts.wallet){
        contacts.add({
          'name' : wallet.name,
          'id' : wallet.id
        });
      }
      for(NonWallet wallet in value.contacts.nonWallet){
        contacts.add({
          'name' : wallet.name,
          'id' : wallet.id
        });
      }
      print(contacts);
      update();
    });
  }

  getReports(String token) async {
    print('getReport');
    responseModel =await GetTransactionHistoryApi().getTransactionHistory(token);
    historyList = responseModel.history.reversed.toList();
    filteredList = responseModel.history.reversed.toList();
    filteredFromDateList = responseModel.history.reversed.toList();
    splitListItems(1);
    getContacts(token);
    update();
  }

  setTransactionType(String type){
    transactionType = type;
    sortByTransactionType();
    update();
  }

  sortByContacts(){

  }
  sortByTransactionType(){
    print(transactionType);
    switch(transactionType){
      case 'All Transactions':
        filteredList.clear();
        for(History e in filteredFromDateList){
          filteredList.add(e);
        }
        update();
        break;
      case 'Send Money To Wallet':
        filteredList.clear();
        for(History e in filteredFromDateList){
          if(e.value.txData[0].txName=='Wallet to Wallet'){
            filteredList.add(e);
          }
        }
        update();
        break;
      case 'Send Money To Non Wallet':
        filteredList.clear();
        for(History e in filteredFromDateList){
          if(e.value.txData[0].txName=='Non Wallet to Wallet'){
            filteredList.add(e);
          }
        }
        update();
        break;

      case 'Bill Payments':
        filteredList.clear();
        for(History e in filteredFromDateList){
          if(e.value.txData[0].txName=='Wallet to Merchant'){
            filteredList.add(e);
          }
        }
        update();
        break;
    }
  }
     
  sortListByDate(){
    print('sort by date');
    filteredList.clear();
    for(int i = 0;i<historyList.length;i++){
      if(DateFormat("yyyy-MM-dd HH:mm:ss").parse(historyList[i].timestamp, true).isAfter(fromDate) && DateFormat("yyyy-MM-dd HH:mm:ss").parse(historyList[i].timestamp, true).isBefore(toDate)){
        filteredList.add(historyList[i]);
        filteredFromDateList.add(historyList[i]);
      }
    }
    print('sort by date end');
  }

  Future<Null> selectToDate(BuildContext context)async{
    print('select to date');
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if(picked !=null && picked!=DateTime.now()){
      toDate = picked;
      sortListByDate();
      update();
    }
  }

  splitListItems(int counter){
    print(historyList.length);
    if(historyList.length>=counter*10){
      print(counter);
      filteredList = historyList.sublist((counter-1)*10,counter*10);
    }else{
      filteredList = historyList.sublist((counter-1)*10);
    }
    update();
  }

  incrementPage(){
    if(filteredList.length>=(pageNumber-2)*10){
      pageNumber++;
      splitListItems(pageNumber);
      update();
    }
  }

  decrementPage(){
    if(pageNumber>1){
      pageNumber--;
      splitListItems(pageNumber);
      update();
    }
  }

  Future<Null> selectFromDate(BuildContext context)async{
    print('select from date');
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: 8)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if(picked !=null && picked!=DateTime.now()){
      fromDate = picked;
      sortListByDate();
      update();
    }
  }
}